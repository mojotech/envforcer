require 'spec_helper'

describe EnvEnforcer do
  ENV = {
    KEY_ONE: 'my key'
  }

  it 'works' do
    expect { EnvEnforcer.call }.not_to raise_error
  end
end