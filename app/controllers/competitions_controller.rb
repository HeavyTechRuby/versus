# frozen_string_literal: true

class CompetitionsController < ApplicationController
  before_action :authenticate_user!, except: %i[index show]
  before_action :find_competition, only: %i[show edit update destroy]

  def index
    @competitions = Competition.all
  end

  def show; end

  def new
    @competition = Competition.new
  end

  def edit
    authorize!(:edit, @competition)
  end

  def create
    @competition = Competition.new(create_competition_params)
    respond_to do |format|
      if @competition.save
        format.html { redirect_to competition_path(@competition), notice: t('versus.created') }
        format.json { render :show, status: :created, location: @competition }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @competition.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    authorize!(:update, @competition)

    respond_to do |format|
      if @competition.update(competition_params)
        format.html { redirect_to competition_path(@competition), notice: t('versus.updated') }
        format.json { render :show, status: :ok, location: @competition }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @competition.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy; end

  private

  def find_competition
    @competition = Competition.find(params[:id])
  end

  def competition_params
    params.require(:competition).permit(:name, :description)
  end

  def create_competition_params
    competition_params.merge(author_id: current_user.id)
  end
end
