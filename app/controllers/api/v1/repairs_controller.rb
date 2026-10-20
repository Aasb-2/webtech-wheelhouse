module Api
  module V1
    class RepairsController < BaseController
      before_action :authenticate_token!
      before_action :set_repair, only: [:show]

      def index
        repairs = Repair.newest_first.includes(bike: :customer, repair_line_items: :service_item)

        if params[:state].present?
          unless Repair::STATUSES.include?(params[:state])
            return render_errors(
              ["Invalid state '#{params[:state]}'. Valid states: #{Repair::STATUSES.join(', ')}"],
              :bad_request
            )
          end
          repairs = repairs.where(status: params[:state])
        end

        render json: repairs.map { |repair| repair_json(repair) }
      end

      def show
        render json: repair_json(@repair)
      end

      private

      def set_repair
        @repair = Repair.includes(bike: :customer, repair_line_items: :service_item).find(params[:id])
      end

      def repair_json(repair)
        {
          id: repair.id,
          status: repair.status,
          decision: repair.decision,
          dropped_off_at: repair.dropped_off_at,
          promised_on: repair.promised_on,
          collected_at: repair.collected_at,
          overdue: repair.overdue?,
          total: repair.total,
          bike: {
            model: repair.bike.model,
            serial_number: repair.bike.serial_number
          },
          customer: {
            name: repair.bike.customer.name
          },
          line_items: repair.repair_line_items.map do |line_item|
            {
              service_name: line_item.service_item.name,
              price_charged: line_item.price_charged
            }
          end
        }
      end
    end
  end
end