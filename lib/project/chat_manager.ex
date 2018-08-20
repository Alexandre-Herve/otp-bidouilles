defmodule Project.ChatManager do

  def start_chat(chat_name) do
    child_spec = {Project.ChatServer, chat_name}
    DynamicSupervisor.start_child(Project.DynamicSupervisor, child_spec)
  end

  def terminate_chat(chat_name) do
    [{pid, _}|_] = Registry.lookup(Project.Registry, chat_name)
    DynamicSupervisor.terminate_child(Project.DynamicSupervisor, pid)
  end

end
