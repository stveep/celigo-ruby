require 'spec_helper'

describe Celigo::Confluence do
  before :each do
    @conf = Celigo::Confluence.new('spec/fixtures/test.csv')
  end

  it 'determines the plate type' do
    expect(@conf.type).to eq :well24
    expect(@conf.plate).to eq "24-Well Corning™ 3524 Plate"
  end

  it 'reads % confluence data' do
    expect(@conf.confluency).to eq [[nil,nil,nil,nil,nil,nil],
                                  [nil,61.90545,64.68607,58.31772,27.13809,nil],
                                  [nil,55.73773,48.69783,43.32894,55.90879,nil],
                                  [nil,nil,nil,nil,nil,nil],
                                ]
  end

  it 'reads well sampling' do
    expect(@conf.sampling).to eq  [[nil,nil,nil,nil,nil,nil],
                                  [nil,52.36466,52.36466,52.36466,52.33113,nil],
                                  [nil,52.36466,52.36466,52.36466,52.36466,nil],
                                  [nil,nil,nil,nil,nil,nil],
                                ]

  end
end
