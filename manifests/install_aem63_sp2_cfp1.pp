define aem_curator::install_aem63_sp2_cfp1(
  $aem_license_base,
  $aem_artifacts_base,
  $aem_healthcheck_version,
  $aem_port,
  $run_modes,
  $tmp_dir,
  $aem_base                = '/opt',
  $aem_healthcheck_source  = undef,
  $aem_id                  = 'aem',
  $aem_jvm_mem_opts        = '-Xss4m -Xmx8192m',
  $aem_sample_content      = false,
  $aem_jvm_opts            = [
    '-XX:+PrintGCDetails',
    '-XX:+PrintGCTimeStamps',
    '-XX:+PrintGCDateStamps',
    '-XX:+PrintTenuringDistribution',
    '-XX:+PrintGCApplicationStoppedTime',
    '-XX:+HeapDumpOnOutOfMemoryError',
  ],
  $aem_start_opts          = '',
  $post_install_sleep_secs = 120,
) {

  aem_curator::install_aem63 { "${aem_id}: Install AEM":
    tmp_dir                 => $tmp_dir,
    run_modes               => $run_modes,
    aem_port                => $aem_port,
    aem_artifacts_base      => $aem_artifacts_base,
    aem_license_base        => $aem_license_base,
    aem_healthcheck_version => $aem_healthcheck_version,
    aem_healthcheck_source  => $aem_healthcheck_source,
    aem_base                => $aem_base,
    aem_sample_content      => $aem_sample_content,
    aem_jvm_mem_opts        => $aem_jvm_mem_opts,
    aem_jvm_opts            => $aem_jvm_opts,
    aem_start_opts          => $aem_start_opts,
    post_install_sleep_secs => $post_install_sleep_secs,
    aem_id                  => $aem_id,
  } -> aem_curator::install_aem_package { "${aem_id}: Install service pack 2":
    tmp_dir         => $tmp_dir,
    file_name       => 'AEM-6.3.2.0-6.3.2.zip',
    package_name    => 'aem-service-pkg',
    package_group   => 'adobe/cq630/servicepack',
    package_version => '6.3.2',
    artifacts_base  => $aem_artifacts_base,
    aem_id          => $aem_id,
  } -> aem_curator::install_aem_package { "${aem_id}: Install cumulative fix pack 1":
    tmp_dir                 => $tmp_dir,
    file_name               => 'AEM-CFP-6.3.2.1-1.0.zip',
    package_name            => 'aem-6.3.2-cfp',
    package_group           => 'adobe/cq630/cumulativefixpack',
    post_install_sleep_secs => 900,
    package_version         => '1.0',
    artifacts_base          => $aem_artifacts_base,
    aem_id                  => $aem_id,
  }

}
