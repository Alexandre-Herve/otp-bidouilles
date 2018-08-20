defmodule Project do

  use Application

  def start(_type, _args) do
    children = [
      {Registry, keys: :unique, name: Project.Registry},
      {DynamicSupervisor, strategy: :one_for_one, name: Project.DynamicSupervisor}
    ]
    opts = [strategy: :one_for_one, name: Project.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
