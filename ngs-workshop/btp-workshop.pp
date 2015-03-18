# Helper resource for the directories
define workshop_dir {
  file { "${title}":
    ensure  => directory,
    recurse => true,
    mode    => '0755',
    owner   => $btp_workshop::trainee_user,
    group   => $btp_workshop::trainee_user,
  }
}

# Helper resource for downloading a remote file
define remote_file($remote_location, $destination, $mode=0644, $owner, $group) {
  exec { "get_${title}":
    command => "/usr/bin/wget -q ${remote_location} -O ${destination}",
    creates => "${destination}",
  }
   
  file { "${destination}":
    mode    => $mode,
    owner   => $owner,
    group   => $group,
    require => Exec["get_${title}"],
  }
}

# Helper resource for the workshop files
define workshop_file($location, $link) {
  remote_file { $title:
    remote_location => "${location}/${title}",
    mode            => '0644',
    owner           => $btp_workshop::trainee_user,
    group           => $btp_workshop::trainee_user,
  }
    
  file { "${link}/${title}":
    ensure  => link,
    target  => "${btp_workshop::data_path}/${title}",
    owner   => $btp_workshop::trainee_user,
    group   => $btp_workshop::trainee_user,
    require => [Workshop_dir[$link], Remote_file[$title]],
  }
}

define workshop_data($location, $destination, $module) {
  remote_file { "${module}_${title}":
    remote_location => "${location}/${title}",
    destination     => "${destination}/${title}",
    owner           => $trainee_user,
    group           => $trainee_user,
  }
}

define workshop_subdirs {
  $parent_path = hiera('btp_workshop::parent_path')
  $working_dir = hiera('btp_workshop::working_dir')

  workshop_dir { "${parent_path}/${working_dir}/${name}": 
    require => Workshop_dir[$parent_path],
  }
}

define workshop_modules($location, $data, $dirs) {
  $parent_path = hiera('btp_workshop::parent_path')
  $data_dir = hiera('btp_workshop::data_dir')
  $working_dir = hiera('btp_workshop::working_dir')

  $data_path = "${parent_path}/${data_dir}"
  $working_path = "${parent_path}/${working_dir}"

  workshop_data { $data:
    location    => $location,
    destination => "${parent_path}/${data_dir}",
    module      => $name,
    require     => [ Workshop_dir[$working_path],
                   Workshop_dir[$data_path] ],
  }

  workshop_subdirs { $dirs: 
    before => File["/home/${btp_workshop::trainee_user}/${name}"],
  }

  file { [ "/home/${btp_workshop::trainee_user}/${name}", 
           "/home/${btp_workshop::trainee_user}/Desktop/${name}" ]:
    ensure => 'link',
    target => "${parent_path}/${working_dir}/${name}",
    owner  => $btp_workshop::trainee_user,
    group  => $btp_workshop::trainee_user,
  }
}

class btp_workshop {
  $parent_path = hiera('btp_workshop::parent_path')
  $data_dir = hiera('btp_workshop::data_dir')
  $working_dir = hiera('btp_workshop::working_dir')
  $trainee_user = hiera('btp_workshop::trainee_user')
  $trainee_uid = hiera('btp_workshop::trainee_uid')
  $modules = hiera('btp_workshop::modules', {})

  $data_path = "${parent_path}/${data_dir}"
  $working_path = "${parent_path}/${working_dir}"

  # Defaults
  File {
    owner => $trainee_user,
    group => $trainee_user,
  }

  # Trainee group
  group { $trainee_user:
    ensure => present,
  }

  # Trainee user's home directory
  workshop_dir { "/home/${trainee_user}": }

  # Trainee user's desktop directory
  workshop_dir { "/home/${trainee_user}/Desktop":
    require => Workshop_dir["/home/${trainee_user}"],
  }

  # Trainee user
  user { $trainee_user:
    ensure  => present,
    uid     => $trainee_uid,
    gid     => $trainee_user,
    shell   => '/bin/bash',
    home    => "/home/${trainee_user}",
    require => Group[$trainee_user],
  }

  # Parent path
  workshop_dir { $parent_path:
    require => User[$trainee_user],
  }

  # Data directory
  workshop_dir { $data_path:
    require => Workshop_dir[$parent_path],
  }

  # Working directory
  workshop_dir { $working_path:
    require => Workshop_dir[$parent_path],
  }

  create_resources(workshop_modules, $modules)
}

node default {
  include btp_workshop
}
