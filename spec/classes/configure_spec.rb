require 'spec_helper'
describe 'tmux::configure' do
    it { should compile() }
    it { should contain_class('tmux::configure') }
    it { should contain_file('/tmp/tmux.conf').with_ensure('present') }
end
describe 'tmux::configure::prefix' do
    let(:prefix) { 'b' }
    it { should compile() }
    it { should contain_class('tmux::configure::prefix') }
    it { should contain_tmux__confwriter("Appending Prefix").with_line("set option -g prefix C-#{prefix}")}
end

describe 'tmux::configure::select::panes' do
    let(:up) { 'S-Up' }
    let(:down) { 'S-Down' }
    let(:left) { 'S-Left' }
    let(:right) { 'S-Right' }
    it { should compile() }
    it { should contain_class('tmux::configure::select::panes') }
    it { should contain_tmux__confwriter("Adding pane selection shortcuts left").with_line("bind -n #{left} select-pane -L")}
    it { should contain_tmux__confwriter("Adding pane selection shortcuts right").with_line("bind -n #{right} select-pane -R")}
    it { should contain_tmux__confwriter("Adding pane selection shortcuts up").with_line("bind -n #{up} select-pane -U")}
    it { should contain_tmux__confwriter("Adding pane selection shortcuts down").with_line("bind -n #{down} select-pane -D")}
end

describe 'tmux::configure::mode' do
    let(:mode) { 'vi' }
     it { should compile() }
     it { should contain_class('tmux::configure::mode') }
     it { should contain_tmux__confwriter("Setting mode keys to #{mode}").with_line("set -g mode-keys #{mode}")}
end

describe 'tmux::configure::terminal' do
    let(:terminal) { 'screen-256color' }
     it { should compile() }
     it { should contain_class('tmux::configure::terminal') }
     it { should contain_tmux__confwriter("Setting terminal to #{terminal}").with_line("set -g default-terminal #{terminal}")}
end

describe 'tmux::configure::history' do
    let(:history) { '5000' }
     it { should compile() }
     it { should contain_class('tmux::configure::history') }
     it { should contain_tmux__confwriter("Setting history to #{history}").with_line("set-option -g history-limit #{history}")}
end

describe 'tmux::configure::mouse' do
     it { should compile() }
     it { should contain_class('tmux::configure::mouse') }
     it { should contain_tmux__confwriter("Setting mouse on").with_line("setw -g mode-mouse on")}
     it { should contain_tmux__confwriter("Setting mouse select pane on").with_line("set-option -g mouse-select-pane on")}
     it { should contain_tmux__confwriter("Setting pane resize with mouse").with_line("set -g mouse-resize-pane on")}
end








