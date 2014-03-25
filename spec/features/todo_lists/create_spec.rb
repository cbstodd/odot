require 'spec_helper'

describe "Creating todo lists" do 
  it "redirects from Index to the New todo list index page on success" do 
    visit todo_lists_path
    click_link "New Todo list"
    expect(page).to have_content("New todo_list")

    fill_in "Title", with: "My todo list"
    fill_in "Description", with: "This is what I'm doing today"
    click_button "Create Todo list"

    expect(page).to have_content("My todo list")
  end

  it "displays an error when the todo list title has no info" do 
    expect(TodoList.count).to eq(0)

    visit todo_lists_path
    click_link "New Todo list"
    expect(page).to have_content("New todo_list")

    fill_in "Title", with: ""
    fill_in "Description", with: "This is what I'm doing today"
    click_button "Create Todo list"

    expect(page).to have_content("error")
    expect(TodoList.count).to eq(0)

    visit todo_lists_path
    expect(page).to_not have_content("This is what I'm doing today.")

  end

    it "displays an error when the todo list has a title with less than 3 characters" do 
      expect(TodoList.count).to eq(0)

      visit todo_lists_path
      click_link "New Todo list"
      expect(page).to have_content("New todo_list")

      fill_in "Title", with: "Hi"
      # the word "Hi" is only two characters therefore an example with the minimum of 3.
      fill_in "Description", with: "This is what I'm doing today"
      click_button "Create Todo list"

      expect(page).to have_content("error")
      expect(TodoList.count).to eq(0)

      visit todo_lists_path
      expect(page).to_not have_content("This is what I'm doing today.")

  end

    it "displays an error when the todo list has no discription" do 
      expect(TodoList.count).to eq(0)

      visit todo_lists_path
      click_link "New Todo list"
      expect(page).to have_content("New todo_list")

      fill_in "Title", with: "My todo list"
      fill_in "Description", with: ""
      # Shows no text.
      click_button "Create Todo list"

      expect(page).to have_content("error")
      expect(TodoList.count).to eq(0)

      visit todo_lists_path
      expect(page).to_not have_content("Text should be in the subject area.")

    end
end
