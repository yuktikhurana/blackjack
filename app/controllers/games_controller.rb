class GamesController < ApplicationController
  before_action :set_player_session, only: :start
  before_action :load_player, only: [:index, :show, :hit, :stand]
  before_action :load_game, only: [:show, :hit, :stand]
  before_action :check_game_over, only: [:hit, :stand]

  def index
    @games = @player.games
    @busted_games = @games.busted
    @lost_without_bust_games = @games.lost_without_bust
    @games = @games.to_a
  end

  def show
  end

  def start
    @game = @player.games.new
    if @game.start
      redirect_to game_path(@game)
    else
      redirect_to root_path, alert: @game.errors.full_messages.to_sentence
    end
  end

  def hit
    unless @game.hit
      flash[:error] = @game.errors.full_messages.to_sentence 
    end
    redirect_to game_path(@game)
  end

  def stand
    unless @game.stand
      flash[:error] = @game.errors.full_messages.to_sentence 
    end
    redirect_to game_path(@game)
  end

  private

    def load_game
      unless @game = Game.where(id: params[:id]).first
        redirect_to root_path, alert: 'Game not found'
      end
    end

    def set_player_session
      unless @player = Player.where(id: session[:player_id]).first
        @player = Player.create 
        session[:player_id] = @player.id
      end
    end

    def load_player
      unless @player = Player.where(id: session[:player_id]).first
        redirect_to root_path, alert: 'Player not found'
      end
    end

    def check_game_over
      if @game.over?
        redirect_to game_path(@game)
      end
    end
end
