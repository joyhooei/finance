desc "系统重试交易"

namespace :callqueue do
	desc "重试交易-第三方系统判断交易是否成功"
	task :online_pay_is_succ=>[:environment] do 
		@interface_logger = Logger.new("log/call_queue.log")
		@interface_logger.level=Logger::INFO
		@interface_logger.datetime_format="%Y-%m-%d %H:%M:%S"
		@interface_logger.formatter=proc{|severity,datetime,progname,msg|
			"[#{datetime}] :#{msg}\n"
		}
		@interface_logger.info("callqueue online_pay_is_succ start")

		CallQueue.polling("online_pay_is_succ")
		
		@interface_logger.info("callqueue  online_pay_is_succ end")
	end

	desc "获取支付包裹的物流信息及推送"
	task :track_info_proc=>[:environment] do 
		@interface_logger = Logger.new("log/cron_track_info_proc.log")
		@interface_logger.level=Logger::INFO
		@interface_logger.datetime_format="%Y-%m-%d %H:%M:%S"
		@interface_logger.formatter=proc{|severity,datetime,progname,msg|
			"[#{datetime}] :#{msg}\n"
		}
		@interface_logger.info("callqueue online_pay_is_succ start")

		CallQueue.oceanpayment_push_task_get_info()
		CallQueue.oceanpayment_push_task_push()
		
		@interface_logger.info("callqueue  online_pay_is_succ end")
	end
end

