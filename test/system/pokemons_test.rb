require "application_system_test_case"

class PokemonsTest < ApplicationSystemTestCase
  test "visiting the index" do
    visit pokemons_url

    assert_selector "h1", text: "Hello pokemon"

    click_on "Signup"

    fill_in "Name", with: "systemtest"
    fill_in "Email", with: "systemtest@email.com"
    fill_in "Password", with: "password"
    fill_in "Password confirmation", with: "password"

    click_on "Create User"
    assert_selector "h1", text: "Hello pokemon"

    click_on "Your Pokemon"
    assert_selector "h1", text: "Your Pokemon"

    click_on "New Unique Pokemon"
    assert_selector "h1", text: "New Unique Pokemon"
    fill_in "Nickname", with: "system_test_name"
    fill_in "Nature", with: "system_test_nature"
    fill_in "Shiny", with: "true"
    # take_screenshot

    click_on "Create Unique pokemon"
    assert_selector "h3", text: "#{UniquePokemon.last.pokemon.name}"

    click_on "back to your pokemon"
    assert_selector "h5", text: "#{UniquePokemon.last.pokemon.name}"

    click_on "Go to page"
    assert_selector "h3", text: "#{UniquePokemon.last.pokemon.name}"

    click_on "back to your pokemon"

    click_on "New Unique Pokemon"
    assert_selector "h1", text: "New Unique Pokemon"
    fill_in "Nickname", with: "system_test_name"
    fill_in "Nature", with: "system_test_nature"
    fill_in "Shiny", with: "true"
    # take_screenshot

    click_on "Create Unique pokemon"
    assert_selector "h3", text: "#{UniquePokemon.last.pokemon.name}"

    click_on "back to your pokemon"
    assert_selector "h5", text: "#{UniquePokemon.last.pokemon.name}"

    # click_on "Go to page"
    # assert_selector "h3", text: "#{UniquePokemon.last.pokemon.name}"
  end
end
