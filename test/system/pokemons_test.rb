require "application_system_test_case"

class PokemonsTest < ApplicationSystemTestCase
  test "navigating the website" do
    visit "/pokemons"
    assert_selector "h1", text: "Hello pokemon"
    take_screenshot # 1

    click_on "Signup"

    fill_in "Name", with: "systemtest"
    fill_in "Email", with: "systemtest@email.com"
    fill_in "Password", with: "password"
    fill_in "Password confirmation", with: "password"
    take_screenshot # 2

    click_on "Create User"
    assert_selector "h1", text: "Hello pokemon"
    take_screenshot # 3

    click_on "Your Pokemon"
    assert_selector "h1", text: "Your Pokemon"
    take_screenshot # 4

    click_on "New Unique Pokemon"
    assert_selector "h1", text: "New Unique Pokemon"
    fill_in "Nickname", with: "system_test_name"
    fill_in "Nature", with: "system_test_nature"
    fill_in "Shiny", with: "true"
    take_screenshot # 5

    click_on "Create Unique pokemon"
    assert_selector "h3", text: "#{UniquePokemon.last.pokemon.name}"
    assert_selector "img", class: "atk_ev_bar"
    take_screenshot # 6

    click_on "back to your pokemon"
    assert_selector "h5", text: "#{UniquePokemon.last.pokemon.name}"
    take_screenshot # 7

    click_on "Go to page"
    assert_selector "h3", text: "#{UniquePokemon.last.pokemon.name}"
    if assert_selector "img", class: "atk_ev_bar"
      puts "hello"
    end
    take_screenshot # 8

    click_on "back to your pokemon"
    assert_selector "h5", text: "#{UniquePokemon.last.pokemon.name}"
    take_screenshot # 9

    click_on "Go to page"
    assert_selector "h3", text: "#{UniquePokemon.last.pokemon.name}"
    take_screenshot # 10

    # click_on "Go to page"
    # assert_selector "h3", text: "#{UniquePokemon.last.pokemon.name}"

    click_on "Logout"
    assert_selector "h1", text: "Login"
    fill_in "Email", with: "systemtest@email.com"
    fill_in "Password", with: "password"
    take_screenshot # 11

    click_on "Submit"
    assert_selector "h1", text: "Hello pokemon"
    take_screenshot # 12

    click_on "Your Pokemon"
    assert_selector "h1", text: "Your Pokemon"
    take_screenshot # 13
  end
end
