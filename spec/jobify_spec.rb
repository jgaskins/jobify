require 'jobify'

RSpec.describe Jobify do
  let(:input) do
    <<-EOF
Lead Chef, Chipotle, Denver, CO, 10, 15
Stunt Double, Equity, Los Angeles, CA, 15, 25
Manager of Fun, IBM, Albany, NY, 30, 40
Associate Tattoo Artist, Tit 4 Tat, Brooklyn, NY, 250, 275
Assistant to the Regional Manager, IBM, Scranton, PA, 10, 15
Lead Guitarist, Philharmonic, Woodstock, NY, 100, 200
    EOF
  end

  it 'loads jobs' do
    jobs = Jobify.from_string(input)
    expect(jobs.count).to eq 6
    expect(jobs.first.title).to eq 'Lead Chef'
    expect(jobs.first.organization).to eq 'Chipotle'
    expect(jobs.first.location).to eq 'Denver, CO'
    expect(jobs.first.min).to eq 10
    expect(jobs.first.max).to eq 15
  end

  it 'formats the output of a job' do
    jobs = Jobify.from_string(input)

    expect(Jobify.report(jobs)).to eq <<-EOF
All Opportunities
Title: Assistant to the Regional Manager, Organization: IBM, Location: Scranton, PA, Pay: 10-15
Title: Associate Tattoo Artist, Organization: Tit 4 Tat, Location: Brooklyn, NY, Pay: 250-275
Title: Lead Chef, Organization: Chipotle, Location: Denver, CO, Pay: 10-15
Title: Lead Guitarist, Organization: Philharmonic, Location: Woodstock, NY, Pay: 100-200
Title: Manager of Fun, Organization: IBM, Location: Albany, NY, Pay: 30-40
Title: Stunt Double, Organization: Equity, Location: Los Angeles, CA, Pay: 15-25
    EOF

  end
end
