Given(/^the user has just accessed the homepage$/) do
	visit('/')
end

When(/^the grid has loaded$/) do
	expect(has_xpath?("//div[@id='sudoku']")).to be_true
end

Then(/^the user should see a nine by nine grid$/) do
	expect(has_selector?('input', :count => 81)).to be_true
end

And(/^there should be a header$/) do
	expect(has_selector?('h1')).to be_true
end

# =============================================================
#              WHEN USER ENTERS VALUE INTO FIRST CELL
# =============================================================

Given(/^the the user inputs an incorrect value into the first cell$/) do
	fill_in 'cell-0', :with => 1
end

When(/^the user clicks the check solution button$/) do
	click_button('check-solution')
end

Then(/^the user should see an incorrect answer highlighed$/) do
	
end