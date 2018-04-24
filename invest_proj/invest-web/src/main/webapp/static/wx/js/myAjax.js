(
	function($) {
		$.extend({
			cc: {}
		});
		$.extend($.cc, {
			ajax: function(option) {
				$.ajax({
					type: option.type || 'GET',
					data: option.data || null,
					url: option.url || '',
					cache:option.cache||true,
					async:option.async||true,
					dataType: option.dataType || "json",
					beforeSend: function(xhr) {
						if(option.beforeSend) option.beforeSend(xhr);
					},
					complete: function(xhr) {
						if(option.complete) option.complete(xhr);
					},
					success: function(data) {
						if(option.success) option.success(data)
					}
				})
			}
		});
	}
)(jQuery)