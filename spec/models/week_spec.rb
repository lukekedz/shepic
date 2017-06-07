require 'rails_helper'

describe Week, :type => :model do
    subject { described_class.new }

    it 'is valid with valid attributes' do
        subject.week = Random.rand(100)
        expect(subject).to be_valid
    end

    it 'is not valid without a week integer' do
        expect(subject).to_not be_valid
    end
end

describe 'self.current()' do
    it 'should respond_to method' do 
        expect(Week).respond_to? :current
    end

    it 'should return Week with highest id' do 
        last_week = Week.all.last
        expect(Week.current.id).to eq(last_week.id) 
    end
end
