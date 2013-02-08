
package "iscsitarget"
package "iscsitarget-dkms"

file "/etc/default/iscsitarget" do
  content "ISCSITARGET_ENABLE=true"
end

template "/etc/iet/ietd.conf" do
  source "ietd.conf.erb"
  variables(
    :incominguser => node[:ietd][:incominguser],
    :outgoinguser => node[:ietd][:outgoinguser],
    :targets => node[:ietd][:targets] )
  notifies :restart, "service[iscsitarget]"
end

template "/etc/iet/initiators.allow" do
  source "initiators.allow.erb"
  variables( :allow => node[:ietd][:initiators_allow] )
  notifies :restart, "service[iscsitarget]"
end

template "/etc/iet/targets.allow" do
  source "targets.allow.erb"
  variables( :allow => node[:ietd][:targets_allow] )
  notifies :restart, "service[iscsitarget]"
end

service "iscsitarget" do
  supports :status => true, :restart => true
  action [:enable, :start]
end
