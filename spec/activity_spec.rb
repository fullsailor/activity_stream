
describe ActivityStream::Activity do
  
  it "can define a activity" do
    Activity.define(:example_activity).should be_an_instance_of(ActivityStream::Definition)
  end
  

end