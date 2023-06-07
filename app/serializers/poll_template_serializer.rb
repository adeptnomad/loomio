class PollTemplateSerializer < ActiveModel::Serializer
  embed :ids, include: true
  attributes :id,
             :key,
             :group_id,
             :position,
             :author_id,
             :poll_type,
             :process_name,
             :process_subtitle,
             :process_introduction,
             :process_introduction_format,
             :process_url,
             :tags,
             :title,
             :details,
             :details_format,
             :anonymous,
             :specified_voters_only,
             :notify_on_closing_soon,
             :content_locale,
             :shuffle_options,
             :allow_long_reason,
             :hide_results,
             :chart_type,
             :min_score,
             :max_score,
             :minimum_stance_choices,
             :maximum_stance_choices,
             :dots_per_person,
             :reason_prompt,
             :poll_options,
             :poll_option_name_format,
             :stance_reason_required,
             :limit_reason_length,
             :default_duration_in_days,
             :agree_target,
             :created_at,
             :updated_at,
             :discarded_at
end
