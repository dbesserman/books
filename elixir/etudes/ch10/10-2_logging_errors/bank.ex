defmodule Bank do
  require Logger

  def acount(balance) do
    input     = IO.gets("D)eposit, W)ithdraw, B)alance, Q)uit: ")
    action    = Sting.downcase(String.first(input))

    if (action != "q" do
      new_balance = transaction(action, balance)
      account(balance)
    end
  end

  def transaction(action, balance) do
    case action do
      "d" ->
        amount = get_number("Amount to deposit: ")

        cond do
          amount >= 1000 ->
            :error_logger.warning_msg "Large deposit $#{amount}\n"
            IO.puts "Your deposit of $#{amount} may be subject to hold.\n"
            new_balance = balance + amount
            IO.puts "Your new balance is $#{new_balance}\n"
          amount < 0 ->
            :error_logger.error_msg "Negative deposit $#{new_balance}.\n"
            IO.puts "Deposits may not be less than zero."
            new_balance = balance
          amount > 0 ->
            :error_logger.info_msg "Successful deposit of $#{amount}.\n"
            new_balance = balance + amount
            IO.puts "Your new balance is $#{new_balance}\n"
        end
      "w" ->
        amount = get_number("Amount to deposit: ")
        cond do
          amount > balance ->
            :error_logger.error_msg "Overdraw $#{amount} from $#{balance}\n"
            IO.puts "You cannot withdraw more than your current balance of $#{balance}\n"
            new_balance = balance
          amount < 0 ->
            :error_logger.error_msg "Negative withdrawal $#{new_balance}.\n"
            IO.puts "Withdrawal may not be less than zero."
            new_balance = balance
          amount >= 0 ->
            :error_logger.info_msg "Successful withdrawal of $#{amount}.\n"
            new_balance = balance - amount
            IO.puts "Your new balance is $#{new_balance}\n"
        end
      "b" ->
        :error_logger.info_msg("Balance inquiry $#{balance}\n"
        IO.puts "Your current balance is $#{balance}"
        new_balance = balance
      _ ->
        IO.puts "Unknown command #{action}"
        new_balance = balance
    end

  end

  defp get_number(prompt) do
    input     = IO.gets("Enter #{prompt} > ")
    input_str = String.trim(input)

    cond do
      Regex.match?(~r/^[+-]?\d+$/, input_str)                       -> String.to_integer(input_str)
      Regex.match?(~r/^[+-]?\d+\.\d+([eE][+-]?\d+)?$/, input_str)   -> String.to_float(input_str)
      true                                                          -> :error
    end
  end
end
