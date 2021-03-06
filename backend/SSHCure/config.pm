######################################################################
#
#  config.pm
#  Authors: Rick Hofstede <r.j.hofstede@utwente.nl>
#           Luuk Hendriks <luuk.hendriks@utwente.nl>
#  University of Twente, The Netherlands
# 
#  LICENSE TERMS: 3-clause BSD license (outlined in license.html) 
#
######################################################################

# For more information on the various settings in this file, we refer to Section 3 of the manual.

# Override the NfSen sources to be used. Multiple values separated by ":".
# If OVERRIDE_SOURCE is empty, all profile sources are used. Default: "".
$OVERRIDE_SOURCE = "";

# The specification of the internal network(s) is used for SSHCure to determine what is ingress and egress traffic.
# The networks must be specified as a comma-separated list of subnets. Examples: "192.168.0.0/16" or "192.168.0.0/16,172.16.0.0/20"
$INTERNAL_NETWORKS = "";

# The maintenance mechanism purges old entries from the database. For further fine-tuning see constants.pm.
%MAINTENANCE = (
    # TRIGGERS: set the day/time on which maintenance should occur.
    # Format is <day_of_week>:<hour_of_day>. Compared against strftime %u and %H, e.g. 7:00 means 7th day (Sunday) at 00:00h
    # Multiple values possible in perl list notation, defaults to Monday, Wednesday and Friday nights at 3AM: [ "1:03", "3:03", "5:03" ]
    'TRIGGERS' => [ "1:03", "3:03", "5:03" ],
    
    # TIME_NEEDED: Indication of time needed for a cleanup routine, default 60.
    # Based on how much of the default 5 minutes nfcapd inter-file-interval is left, the routine is triggered or not.
    'TIME_NEEDED' => 120,
    
    # QUICK: If enabled (1), the database is not reindexed during maintenance. This significantly reduces the
    # time needed for database maintenance.
    'QUICK' => 0,
);

# Indicates whether scan phase targets should be stored in the database. Disabling this significantly reduces database
# size and performance. Default: 1.
$STORE_SCAN_TARGETS = 1;

# Comma-separated list of IP addresses or prefixes (e.g., 130.89.2.2 or 130.89.0.0/16)
# The 'sources' list will prevent an attack from being added based on the attacker,
# while the 'destinations' list will prevent an attack from being added based on the target.
%WHITELIST = ('sources' => '' , 'destinations' => '');

%NOTIFICATIONS = (
    # The notification functionality can host one or more 'notification_configs'. See Section 3.1.2 of the manual for more details.
    
    # 'NOTIFICATION_CONFIG_EXAMPLE_1' => {
    #     # Comma-separated list of IP addresses or prefixes (e.g., 1.2.3.4 or 1.2.3.4/16)
    #     'filter'                    => '1.2.3.4/16',
    #     
    #     # Indicates where 'filter' should be the address of attacker or target.
    #     # Supported values:
    #     #   - $CONST{'NOTIFICATIONS'}{'FILTER_TYPE'}{'ATTACKER'}
    #     #   - $CONST{'NOTIFICATIONS'}{'FILTER_TYPE'}{'TARGET'}
    #     'filter_type'               => $CONST{'NOTIFICATIONS'}{'FILTER_TYPE'}{'ATTACKER'},
    #     
    #     # Attack phase that triggers the notification.
    #     # Supported values:
    #     #   - $CONST{'NOTIFICATIONS'}{'ATTACK_PHASE'}{'SCAN'}
    #     #   - $CONST{'NOTIFICATIONS'}{'ATTACK_PHASE'}{'BRUTEFORCE'}
    #     #   - $CONST{'NOTIFICATIONS'}{'ATTACK_PHASE'}{'COMPROMISE'}
    #     'attack_phase'              => $CONST{'NOTIFICATIONS'}{'ATTACK_PHASE'}{'SCAN'},
    #     
    #     # Indicates when the notification has to be sent.
    #     # Supported values:
    #     #   - $CONST{'NOTIFICATIONS'}{'WHEN'}{'ATTACK_START'}
    #     #   - $CONST{'NOTIFICATIONS'}{'WHEN'}{'ATTACK_UPDATE'}
    #     #   - $CONST{'NOTIFICATIONS'}{'WHEN'}{'ATTACK_END'}
    #     'when'                      => $CONST{'NOTIFICATIONS'}{'WHEN'}{'ATTACK_START'},
    #     
    #     # Indicates the kind of notification to be sent.
    #     # Supported values:
    #     #   - $CONST{'NOTIFICATIONS'}{'TYPE'}{'EMAIL'}
    #     #   - $CONST{'NOTIFICATIONS'}{'TYPE'}{'IDMEF'}
    #     #   - $CONST{'NOTIFICATIONS'}{'TYPE'}{'IODEF'}
    #     #   - $CONST{'NOTIFICATIONS'}{'TYPE'}{'LOG'}
    #     #   - $CONST{'NOTIFICATIONS'}{'TYPE'}{'QMANAGE'}
    #     #   - $CONST{'NOTIFICATIONS'}{'TYPE'}{'XARF'}
    #     'notification_type'         => $CONST{'NOTIFICATIONS'}{'TYPE'}{'EMAIL'},
    #     
    #     # Indicates the sender of the notification. It can be just a single e-mail address and only needs to be 
    #     # configured for email notifications, and can be left empty in case anything other than 'e-mail' or 'IODEF' has
    #     # been configured as the notification type.
    #     'notification_sender'       => 'sshcure@domain.com',
    #     
    #     # Comma-separated list of notification destinations. When 'e-mail' or 'IODEF' have been selected as the notification
    #     # type, the destinations are e-mail addresses. When 'log' file has been selected, it's the (absolute) log file
    #     # location on the file system. Leave empty in case of other notification types.
    #     'notification_destination'  => 'noc@domain.com'
    # },
    # 'NOTIFICATION_CONFIG_EXAMPLE_2' => {
    #     'filter'                    => '1.2.3.4/16',
    #     'filter_type'               => $CONST{'NOTIFICATIONS'}{'FILTER_TYPE'}{'TARGET'},
    #     'attack_phase'              => $CONST{'NOTIFICATIONS'}{'ATTACK_PHASE'}{'COMPROMISE'},
    #     'when'                      => $CONST{'NOTIFICATIONS'}{'WHEN'}{'ATTACK_END'},
    #     'notification_type'         => $CONST{'NOTIFICATIONS'}{'TYPE'}{'EMAIL'},
    #     'notification_sender'       => 'sshcure@domain.com',
    #     'notification_destination'  => 'admin@domain.com,noc@domain.com'
    # },
    # 'NOTIFICATION_CONFIG_EXAMPLE_IDMEF' => {
    #     'filter'                    => '1.2.3.4/16',
    #     'filter_type'               => $CONST{'NOTIFICATIONS'}{'FILTER_TYPE'}{'TARGET'},
    #     'attack_phase'              => $CONST{'NOTIFICATIONS'}{'ATTACK_PHASE'}{'COMPROMISE'},
    #     'when'                      => $CONST{'NOTIFICATIONS'}{'WHEN'}{'ATTACK_END'},
    #     'notification_type'         => $CONST{'NOTIFICATIONS'}{'TYPE'}{'IDMEF'},
    #     'notification_sender'       => 'sshcure@domain.com',
    #     'notification_destination'  => 'soc@domain.com' 
    # },
    # 'NOTIFICATION_CONFIG_EXAMPLE_IODEF' => {
    #     'filter'                    => '1.2.3.4/16',
    #     'filter_type'               => $CONST{'NOTIFICATIONS'}{'FILTER_TYPE'}{'TARGET'},
    #     'attack_phase'              => $CONST{'NOTIFICATIONS'}{'ATTACK_PHASE'}{'COMPROMISE'},
    #     'when'                      => $CONST{'NOTIFICATIONS'}{'WHEN'}{'ATTACK_END'},
    #     'notification_type'         => $CONST{'NOTIFICATIONS'}{'TYPE'}{'IODEF'},
    #     'notification_sender'       => 'sshcure@domain.com',
    #     'notification_destination'  => 'soc@domain.com' 
    # },
    # 'NOTIFICATION_CONFIG_EXAMPLE_QMANAGE' => {
    #     'filter'                    => '1.2.3.4/16',
    #     'filter_type'               => $CONST{'NOTIFICATIONS'}{'FILTER_TYPE'}{'TARGET'},
    #     'attack_phase'              => $CONST{'NOTIFICATIONS'}{'ATTACK_PHASE'}{'COMPROMISE'},
    #     'when'                      => $CONST{'NOTIFICATIONS'}{'WHEN'}{'ATTACK_END'},
    #     'notification_type'         => $CONST{'NOTIFICATIONS'}{'TYPE'}{'QMANAGE'},
    #     'notification_sender'       => '',    # (leave empty)
    #     'notification_destination'  => ''     # (leave empty)
    # },
    # 'NOTIFICATION_CONFIG_EXAMPLE_XARF' => {
    #     'filter'                    => '1.2.3.4/16',
    #     'filter_type'               => $CONST{'NOTIFICATIONS'}{'FILTER_TYPE'}{'TARGET'},
    #     'attack_phase'              => $CONST{'NOTIFICATIONS'}{'ATTACK_PHASE'}{'COMPROMISE'},
    #     'when'                      => $CONST{'NOTIFICATIONS'}{'WHEN'}{'ATTACK_END'},
    #     'notification_type'         => $CONST{'NOTIFICATIONS'}{'TYPE'}{'XARF'},
    #     'notification_sender'       => 'sshcure@domain.com',
    #     'notification_destination'  => 'soc@domain.com'
    # }
);

1;
