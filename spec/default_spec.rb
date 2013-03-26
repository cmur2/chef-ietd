require 'chefspec'

describe 'ietd::default' do
  let(:chef_runner) do
    cb_path = [Pathname.new(File.join(File.dirname(__FILE__), '..', '..')).cleanpath.to_s, 'spec/support/cookbooks']
    ChefSpec::ChefRunner.new(:cookbook_path => cb_path)
  end

  let(:chef_run) do
    chef_runner.converge 'ietd::default'
  end

  it 'installs ietd' do
    expect(chef_run).to install_package 'iscsitarget'
    expect(chef_run).to install_package 'iscsitarget-dkms'
  end
  
  it 'configures targets' do
    chef_runner.node.set['ietd']['targets'] = [
      {
        'iqn' => 'iqn.2013-01.org.example:storage',
        'luns' => []
      }
    ]
    chef_run = chef_runner.converge 'ietd::default'
    expect(chef_run).to create_file_with_content "/etc/iet/ietd.conf", "Target iqn.2013-01.org.example:storage"
  end
  
  it 'configures allowed initators' do
    expect(chef_run).to create_file_with_content "/etc/iet/initiators.allow", "ALL ALL"
  end
  
  it 'configures allowed targets' do
    expect(chef_run).to create_file_with_content "/etc/iet/targets.allow", "ALL ALL"
  end

  it 'allows ietd to start' do
    expect(chef_run).to create_file_with_content "/etc/default/iscsitarget", "ISCSITARGET_ENABLE=true"
  end
  
  it 'enables and starts ietd' do
    expect(chef_run).to start_service "iscsitarget"
    expect(chef_run).to set_service_to_start_on_boot "iscsitarget"
  end
end
