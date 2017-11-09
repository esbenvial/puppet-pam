# pam module
class pam (
  Boolean $sss_enabled          = $::pam::params::sss_enabled,
  Stdlib::Absolutepath $etcpamd = $::pam::params::etcpamd,
  Hash $services                = $::pam::params::services,
) inherits ::pam::params {

  contain pam::install

  $services.each |String $service, $entries| {
    pam::service { $service:
      entries => $entries,
    }
  }

}
