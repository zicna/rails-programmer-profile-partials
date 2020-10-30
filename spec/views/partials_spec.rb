require 'rails_helper'
require 'spec_helper'

describe "the navbar partial" do
  it "renders the navbar correctly" do
    render "layouts/navbar"

    expect(response).to include('Programmers We L<span class="glyphicon glyphicon-heart"></span>ve')
  end
end

describe "the programmer partial" do
  let(:programmer) { Programmer.create(
    name: 'Alan Turing',
    home_country: 'United Kingdom',
    birth_date: '1912-06-23',
    death_date: '1954-06-07',
    image: 'https://upload.wikimedia.org/wikipedia/commons/a/a1/Alan_Turing_Aged_16.jpg',
    wikipedia_page: 'https://en.wikipedia.org/wiki/Alan_Turing',
    quote: 'A computer would deserve to be called intelligent if it could deceive a human into believing that it was human.',
    claim_to_fame: 'The Turing machine, breaking the Enigma code'
  ) }

  before do
    render "programmers/programmer", :programmer => programmer
  end

  it "renders the programmer's name" do
    expect(response).to include(programmer.name)
  end

  it "renders the programmer's image" do
    expect(response).to include(programmer.image)
  end

end

describe "the programmers index page" do
  programmers_index = File.open("app/views/programmers/index.html.erb", "r").read

  it "does not use iteration to render the programmers" do
    expect(programmers_index).to_not include(".each")
  end

  it "uses shorthand syntax for rendering the collection of programmers" do
    expect(programmers_index).to include("<%= render @programmers %>")
  end
end

# BONUS: Create a partial that renders a single attribute of a programmer
describe "the attribute partial" do
  let(:programmer) { Programmer.create(
    name: 'Alan Turing',
    home_country: 'United Kingdom',
    birth_date: '1912-06-23',
    death_date: '1954-06-07',
    image: 'https://upload.wikimedia.org/wikipedia/commons/a/a1/Alan_Turing_Aged_16.jpg',
    wikipedia_page: 'https://en.wikipedia.org/wiki/Alan_Turing',
    quote: 'A computer would deserve to be called intelligent if it could deceive a human into believing that it was human.',
    claim_to_fame: 'The Turing machine, breaking the Enigma code'
  ) }

  it "renders any attribute of the programmer" do
      view.lookup_context.prefixes = %w[programmers]
      assign(:programmer, programmer)
      render :template => "programmers/show.html.erb"
      expect(response).not_to include("programmer.send(attribute)")
      expect(response).not_to include("programmer.home_country")

  end

end
