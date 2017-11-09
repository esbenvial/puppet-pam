# pam module
class pam (
  Boolean $sss_enabled          = $::pam::params::sss_enabled,
  Stdlib::Absolutepath $etcpamd = $::pam::params::etcpamd,
  Hash $services                = $::pam::params::services,
  Hash $services_sss            = $::pam::params::services_sss,
) inherits ::pam::params {
  
  if $sss_enabled {      
    $services_real = hasharray_merge($services, $services_sss)
  } else {
    $services_real = $services
  }
  contain pam::install

  $services_real.each |String $service, $entries| {
    pam::service { $service:
      entries => $entries,
    }
  }

}
