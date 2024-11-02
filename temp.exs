defmodule TemperatureConverter do
	@doc "Converts celcius to fahrenheit"
	def celsius_to_fahrenheit(celsius) do
		celsius * 9/5 + 32
	end

	@doc "Converts fahrenheit to kelvin"
	def fahrenheit_to_kelvin(fahrenheit) do
		(fahrenheit - 32) * 5/9 + 273.15
	end

	@doc "Convers kelvin to celsius"
	def kelvin_to_celsius(kelvin) do
		kelvin - 273.15
	end
end




celsius = IO.gets("celcius: ") |> String.trim() |> String.to_float() 
fahrenheit = TemperatureConverter.celsius_to_fahrenheit(celsius)
kelvin = TemperatureConverter.fahrenheit_to_kelvin(fahrenheit)
final_celsius = TemperatureConverter.kelvin_to_celsius(kelvin)
IO.puts "fahrenheit: #{fahrenheit}"
IO.puts "kelvin: #{kelvin}"
IO.puts "final celsius: #{final_celsius}"