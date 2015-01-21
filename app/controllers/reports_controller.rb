class ReportsController < ApplicationController
  # GET /reports
  # GET /reports.json
  def index
    @reports = Report.select(:id, :user_id, :location_id, :category_id, :message, :cached_votes_up, :cached_votes_down, :created_at)
              .order(cached_votes_up: :desc)
              .to_json(include: {
                user: { only: :username },
                location: { only: :name },
                category: { only: :name }
              })

    render json: @reports
  end

  # GET /reports/1
  # GET /reports/1.json
  def show
    @report = Report.select(:id, :user_id, :location_id, :category_id, :message, :cached_votes_up, :cached_votes_down, :created_at)
              .find(params[:id])
              .to_json(include: {
                user: { only: :username },
                location: { only: [:name, :latitude, :longitude] },
                category: { only: :name }
              })

    render json: @report
  end

  # POST /reports
  # POST /reports.json
  def create
    @report = Report.new(report_params)

    @report.user_id = report_params[:user_id]

    @report.category_id = report_params[:category_id]

    # location key either has :name or (:latitude and :longitude)
    if report_params[:location][:name].present?
      location = Location.search_by_name(report_params[:location][:name]).first
    else
      location = Location.search_by_lat_lng(report_params[:location]).first
    end

    if location.present?
      @report.location = location
    else
      @report.location = Location.create(report_params[:location])
    end

    if @report.save
      render json: @report, status: :created, location: @report
    else
      render json: @report.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /reports/1
  # PATCH/PUT /reports/1.json
  def update
    @report = Report.find(params[:id])

    if @report.update(report_params)
      head :no_content
    else
      render json: @report.errors, status: :unprocessable_entity
    end
  end

  # DELETE /reports/1
  # DELETE /reports/1.json
  def destroy
    @report = Report.find(params[:id])
    @report.destroy

    head :no_content
  end

  # POST /reports/like
  def like
    @report = Report.find(params[:id])
    user = User.where(sim_serial_number: params[:sim_serial_number]).first
    user && user.like(@report)

    render json: @report
  end

  private

  def report_params
    params.require(:report).permit(:message, :user_id, :category_id, location: [:latitude, :longitude, :name])
  end
end

