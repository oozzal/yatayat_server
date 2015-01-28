class ReportsController < ApplicationController
  # GET /reports
  # GET /reports.json
  def index
    reports_scope = Report.select(:id, :user_id, :location_id, :category_id, :message, :cached_votes_up, :cached_votes_down, :created_at)

    reports_scope = reports_scope.where('created_at > ?', params[:age].to_i.days.ago) if params[:age].present?

    # if reports at interval of 5 minutes, show the one with most likes first
    time_truncate_string = "date_trunc('hour', created_at) + date_part('minute', created_at)::int / 5 * interval '5 min'"
    @reports = reports_scope.order("#{time_truncate_string} desc")
               .order(cached_votes_up: :desc, cached_votes_down: :asc)
               .to_json(include: {
                 user: { only: [:username, :cached_votes_up, :cached_votes_down] },
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
                user: { only: [:username, :cached_votes_up, :cached_votes_down] },
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

    render json: @report
  end

  # POST /reports/like
  def like
    @report = Report.find(params[:id])
    user = User.where(sim_serial_number: params[:sim_serial_number]).first
    user && user.like(@report)

    render json: @report.to_json(include: { user: { only: [:cached_votes_up, :cached_votes_down] } })
  end

  # POST /reports/dislike
  def dislike
    @report = Report.find(params[:id])
    user = User.where(sim_serial_number: params[:sim_serial_number]).first
    user && user.dislike(@report)

    render json: @report.to_json(include: { user: { only: [:cached_votes_up, :cached_votes_down] } })
  end

  private

  def report_params
    params.require(:report).permit(:message, :user_id, :category_id, location: [:latitude, :longitude, :name])
  end
end

