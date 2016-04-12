require 'fog'

service = Fog::Compute.new({
    :provider            => 'openstack',                                      # OpenStack Fog provider
    :openstack_auth_url  => 'http://87.44.4.2:5000/v3/auth/tokens', # OpenStack Keystone endpoint
    :openstack_username  => 'x15028534',                                  # Your OpenStack Username
    :openstack_tenant    => 'fb9b373f91b64044950227f74eba0fca',                                # Your tenant id
    :openstack_api_key   => 'nci2959303',                              # Your OpenStack Password
    :connection_options  => {}                                                # Optional
})
