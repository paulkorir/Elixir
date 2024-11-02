defmodule BankAccount do
	def open_account(initial_balance) do
		IO.puts "Account opened with initial balance of #{initial_balance}..."
		[{:deposit, initial_balance}]
	end

	def deposit(account, amount) do
		IO.puts "Depositing #{amount}..."
		account ++ [{:deposit, amount}]
	end

	def withdraw(account, amount) do
		IO.puts "Withdrawing #{amount}..."
		total = Enum.reduce(account, 0, fn
			{:deposit, deposit}, total -> total + deposit
			{:withdrawal, withdraw}, total -> total - withdraw
		end)
		IO.puts "Total = #{total}"
		if amount < total do
			# allow the withdrawal
			IO.puts "Processing withdrawal of #{amount}..."
			# mark the withdrawal
			account ++ [{:withdrawal, amount}]
		else
			# insufficient funds
			IO.puts "Insufficient funds!"
			account
		end
	end

	def transaction_history(account) do
		IO.puts "\nAccount history"
		IO.puts String.duplicate("*", 30)
		Enum.each(account, fn
			{:deposit, deposit} -> IO.puts("Deposited #{deposit}.")
			{:withdrawal, withdraw} -> IO.puts("Withdrew #{withdraw}.")
		end)
		total = Enum.reduce(account, 0, fn
			{:deposit, deposit}, total -> total + deposit
			{:withdrawal, withdraw}, total -> total - withdraw
		end)
		IO.puts String.duplicate("*", 30)
		IO.puts "Balance: #{total}"
	end
end


account = BankAccount.open_account(100.0)
account = BankAccount.deposit(account, 50.0)
account = BankAccount.withdraw(account, 30.0)
account = BankAccount.withdraw(account, 200.0)
BankAccount.transaction_history(account)
