# Class: rsync
#
# This module manages rsync
#
class rsync(
  $package_ensure        = 'installed',
  $manage_package        = true,
  $proxyAddress          = undef,
  $destination_directory = 'C:\temp',
  $destination_zipped    = 'cwRsync_5.4.1_x86_Free.zip',
  $destination_unzipped  = 'cwRsync_5.4.1_x86_Free',
  $cwrsync_url           = 'https://www.itefix.net/dl/cwRsync_5.4.1_x86_Free.zip',
) {
  if $manage_package {
    if $::osfamily == 'windows' {
      download_file { 'download-cwrsync':
        url                   => $cwrsync_url,
        destination_directory => $destination_directory,
        proxyAddress          => $proxyAddress,
      } ->

      windows::unzip { "${destination_directory}\\${destination_zipped}":
        destination => $destination_directory,
        creates     => "${destination_directory}\\${destination_unzipped}"
      }
    } else {
      package { 'rsync':
        ensure => $package_ensure,
      } -> Rsync::Get<| |>
    }
  }
}
