class custom_elasticsearch($version='0.90.5') {

  exec { "download_elasticsearch":
    command => "/usr/bin/wget https://download.elasticsearch.org/elasticsearch/elasticsearch/elasticsearch-${version}.deb -O /tmp/elasticsearch-${version}.deb",
    creates => "/tmp/elasticsearch-${version}.deb"
  }

  package { 'openjdk-6-jre-headless': ensure => present }

  class { 'elasticsearch':
    pkg_source  => "/tmp/elasticsearch-${version}.deb",
    require     => [ Package['openjdk-6-jre-headless'], Exec['download_elasticsearch'] ],
    autoupgrade => true,
  }

}

include custom_elasticsearch