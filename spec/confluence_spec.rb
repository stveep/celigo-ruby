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

  it 'outputs a table with correct separator' do
    expected_output = [[nil,nil,nil,nil,nil,nil],
                                  [nil,52.36466,52.36466,52.36466,52.33113,nil],
                                  [nil,52.36466,52.36466,52.36466,52.36466,nil],
                                  [nil,nil,nil,nil,nil,nil],
                                ]
    Celigo.sep = "SEP"
    expect {@conf.output_table(:sampling)}.to output(expected_output.map{|a| a.join("SEP")}.join("\n")+"\n").to_stdout
  end

  it 'outputs a list' do
    expected_output = [[nil,nil,nil,nil,nil,nil],
                                  [nil,52.36466,52.36466,52.36466,52.33113,nil],
                                  [nil,52.36466,52.36466,52.36466,52.36466,nil],
                                  [nil,nil,nil,nil,nil,nil],
                                ]
    Celigo.sep = "\t"
    expect {@conf.output_list(:sampling) {|i,j| i.to_s + j.to_s }}.to output('A1	
A2	
A3	
A4	
A5	
A6	
B1	
B2	52.36466
B3	52.36466
B4	52.36466
B5	52.33113
B6	
C1	
C2	52.36466
C3	52.36466
C4	52.36466
C5	52.36466
C6	
D1	
D2	
D3	
D4	
D5	
D6	
').to_stdout
  end
end
