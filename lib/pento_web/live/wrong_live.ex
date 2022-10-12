defmodule PentoWeb.WrongLive do
  use Phoenix.LiveView, layout: {PentoWeb.LayoutView, "live.html"}

  def mount(_params, _session, socket) do
    {:ok, assign(socket, score: 0, message: "Make a guess:", answer: :rand.uniform(10))}
  end

  def render(assigns) do
    ~H"""
      <h1>Your score: <%= @score %></h1>
      <h2>
        <%= @message %>
        It's <%= time() %>
      </h2>
      <h2>
        <%= for n <- 1..10 do %>
          <a href="#" phx-click="guess" phx-value-number={n}><%= n %></a>
        <% end %>
      </h2>
      <h2>
        Answer: <%= @answer %>
      </h2>
    """
  end

  def time() do
    DateTime.utc_now() |> to_string
  end

  def handle_event("guess", %{"number" => guess} = data, socket) do
    answer = socket.assigns.answer

    {message, score} = check_guess(String.to_integer(guess), answer, socket.assigns.score)

    {
      :noreply,
      assign(
        socket,
        message: message,
        score: score
      )
    }
  end

  defp check_guess(guess, guess, score),
    do: {"Your guess: #{guess}. Correct! Good shit mayne. ", score + 1}

  defp check_guess(guess, _answer, score),
    do: {"Your guess: #{guess}. Wrong. Screw youuuuuuu. ", score - 1}
end
