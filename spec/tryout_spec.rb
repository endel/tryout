require File.expand_path('spec/spec_helper')

describe Tryout do
  it "should allow to access version" do
    Tryout::VERSION.should be_a(String)
  end

  it "should retry 2 times" do
    sample = [
      lambda { raise "error!" },
      lambda { raise "error!" },
      lambda { "fine!" }
    ].each
    Tryout.try { sample.next.call }.retry(3).should == "fine!"
  end

  it "should retry 3 times" do
    sample = [1,2,3].each
    valid = Tryout.try do
      sample.next
    end.retry(3) do |invalid|
      invalid < 3
    end
    valid.should == 3
  end

  it "should raise error when retried more than allowed" do
    sample = [1,2,3,4,5,6].each
    expect do
      valid = Tryout.try do
        sample.next
      end.retry(5) do |invalid|
        invalid < 6
      end
    end.to raise_exception
  end

  it "allow :if option" do
    emptyness = ["", "", "", "hey!"].each
    valid = Tryout.try do
      emptyness.next
    end.retry(5, :if => :empty?)
    valid.should == "hey!"
  end

  it "allow :unless option" do
    presence = ["", "", "", "hey!"].each
    valid = Tryout.try do
      presence.next
    end.retry(5, :unless => :present?)
    valid.should == "hey!"
  end
end

