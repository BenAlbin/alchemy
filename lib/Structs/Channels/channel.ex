defmodule Alchemy.Channel do
  alias Alchemy.OverWrite
  import Alchemy.Structs.Utility
  @moduledoc """
  This module contains useful functions for operating on `Channels`.
  """
  @typedoc """
  Represents a standard channel in a Guild.

  - `id`

    id of this specific channel. Will be the same as the guild for the "#general"
    channel
  - `guild_id`

    the id of the guild this channel is a part of
  - `name`

    the name of the channel

  - `type`

    `:text`, `:voice`, or `:group`
  - `position`

    sorting position of the channel
  - `is_private`

    should be false for guild channels
  - `permission_overwrites`

    an array of `%OverWrite{}` objects
  - `topic`

    the topic of a channel, `nil` for voice
  - `last_message_id`

    the id of the last message sent in the channel, `nil` for voice
  - `bitrate`

    the bitrate of a voice channel, `nil` for text
  - `user_limit`

    the user limit of a voice channel, `nil` for text
  """
  @type t :: %__MODULE__{
    id: String.t,
    guild_id: String.t,
    name: String.t,
    type: atom,
    position: Integer,
    permission_overwrites: [overwrite],
    topic: String.t | nil,
    last_message_id: String.t | nil,
    bitrate: Integer | nil,
    user_limit: Integer | nil
  }
  @typedoc """
  Represents a permission OverWrite object

  - `id`

    role or user id
  - `type`

    either "role", or "member"
  - `allow`

    the bit set of that permission
  - `deny`

    the bit set of that permission
  """
  @type overwrite :: %OverWrite{
    id: String.t,
    type: String.t,
    allow: Integer,
    deny: Integer
  }
  @derive Poison.Encoder
  defstruct [:id,
             :guild_id,
             :name,
             :type,
             :position,
             :permission_overwrites,
             :topic,
             :last_message_id,
             :bitrate,
             :user_limit]


  @doc false
  def channel_type(code) do
    case code do
      0 -> :text
      1 -> :private
      2 -> :voice
      3 -> :group
    end
  end


  @doc false
  def from_map(map) do
    map
    |> field_map("permission_overwrites", &(map_struct &1, OverWrite))
    |> field_map("type", &channel_type/1)
    |> to_struct(__MODULE__)
  end

end
