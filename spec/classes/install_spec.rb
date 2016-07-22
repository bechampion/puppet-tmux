require 'spec_helper'
describe 'tmux::install' do
    it { should compile() }
    it { should contain_class('tmux::install') }
    it { should contain_class('stdlib') }
    it { should contain_package('tmux').with_ensure('present') }
end
