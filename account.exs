defmodule BankAccount do
	defstruct balance: 0, transactions: []

	@doc "Open an account"
	def open_account(initial_balance) do
		IO.puts "Account opened with initial balance of #{initial_balance}..."
		%BankAccount{balance: initial_balance, transactions: [{:deposit, initial_balance}]}
	end

	@doc "Deposit amount"
	def deposit(%BankAccount{balance: balance, transactions: transactions} = account, amount) do
		IO.puts "Depositing #{amount}..."
		%BankAccount{account | balance: balance + amount, transactions: transactions ++ [{:deposit, amount}]}
	end

	@doc "Withdrawal conditional on sufficient funds"
	def withdraw(%BankAccount{balance: balance, transactions: transactions} = account, amount) do
		IO.puts "Withdrawing #{amount}..."
		if amount <= balance do 
			IO.puts "Processing withdrawal of #{amount}..."
			%BankAccount{account | balance: balance - amount, transactions: transactions ++ [{:withdrawal, amount}]}
		else
			IO.puts "Insufficient funds!"
			account
		end
	end


	@doc "Print transaction history"
	def transaction_history(%BankAccount{balance: balance, transactions: transactions}) do
		IO.puts "\nAccount history"
		IO.puts String.duplicate("*", 30)
		Enum.each(transactions, fn
			{:deposit, deposit} -> IO.puts("Deposited #{deposit}.")
			{:withdrawal, withdraw} -> IO.puts("Withdrew #{withdraw}.")
		end)
		IO.puts String.duplicate("*", 30)
		IO.puts "Balance: #{balance}"
	end
end


account = BankAccount.open_account(100.0)
account = BankAccount.deposit(account, 50.0)
account = BankAccount.withdraw(account, 30.0)
account = BankAccount.withdraw(account, 200.0)
BankAccount.transaction_history(account)
