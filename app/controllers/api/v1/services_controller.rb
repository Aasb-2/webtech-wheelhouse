module Api
  module V1
    class ServicesController < BaseController
      before_action :authenticate_token!, only: [:create]
      before_action :set_service, only: [:show]

      def index
        services = ServiceItem.by_name.to_a
        counts = RepairLineItem.group(:service_item_id).distinct.count(:repair_id)
        render json: services.map { |service| service_json(service, counts[service.id] || 0) }
      end

      def show
        render json: service_json(@service)
      end

      def create
        service = ServiceItem.new(service_params)
        if service.save
          render json: service_json(service), status: :created, location: api_v1_service_url(service)
        else
          render_errors(service.errors.full_messages, :unprocessable_entity)
        end
      end

      private

      def set_service
        @service = ServiceItem.find(params[:id])
      end

      def service_params
        params.expect(service: [:name, :current_price])
      end

      def service_json(service, count = nil)
        {
          id: service.id,
          name: service.name,
          price: service.current_price,
          repairs_charged_count: count || service.repair_line_items.select(:repair_id).distinct.count
        }
      end
    end
  end
end