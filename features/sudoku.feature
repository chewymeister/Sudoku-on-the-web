Feature: showing sudoku
	Upon visiting homepage
	User should see a sudoku grid

	Scenario: When the user visits the homepage
		Given the user has just accessed the homepage
		When the grid has loaded
		Then the user should see a nine by nine grid
		And there should be a header


	Scenario: When the user enters a value into the first cell
		Given the user has just accessed the homepage
		When the the user inputs an incorrect value into the first cell
		When the user clicks the check solution button
		Then the user should see an incorrect answer highlighed


