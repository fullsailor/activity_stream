require 'spec_helper'

describe ActivityStream::Metadata do

  let(:metadata) { ActivityStream::Metadata.new(:example_action) }
  
  before(:each) do
    Activity.define(:example_action) do
      metadata(:one_data)
      metadata(:two_data)
    end
  end
  
  after(:each) do
    ActivityStream::Definition.all.delete(:example_action)
  end
  
  it 'should be initialized with a definition name' do
    ActivityStream::Metadata.new(:example_action)
  end
  
  context 'data storage' do
    
    it 'should accept new data' do
      metadata.store(:one_data, 1)
    end
    
    it 'should retrieve previously set data' do
      metadata.store(:two_data, 2)
      metadata.data[:two_data].should be(2)
    end
    
  end
  
  context 'definition' do
    
    it 'should return one' do
      metadata.definition.should be_a(ActivityStream::Definition)
    end
    
  end

end
