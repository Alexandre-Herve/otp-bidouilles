defmodule Project.ChatServer do

  use GenServer

  # API

  def start_link(chat_name) do
    GenServer.start_link(__MODULE__, [], name: name_spec(chat_name))
  end

  def add_message(chat_name, message) do
    GenServer.cast(name_spec(chat_name), {:add_message, message})
  end

  def get_messages(chat_name) do
    GenServer.call(name_spec(chat_name), :get_messages)
  end

  defp name_spec(name), do: {:via, Registry, {Project.Registry, name}}

  # Server

  @impl true
  def init(messages) do
    {:ok, messages}
  end

  @impl true
  def handle_cast({:add_message, new_message}, messages) do
    {:noreply, [new_message|messages]}
  end

  @impl true
  def handle_call(:get_messages, _from, messages) do
    {:reply, messages, messages}
  end

end
