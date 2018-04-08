<?php

final class StatController extends ControllerBase
{
    private function isSameKeyAllChannelRow($row, $exclude_row, $key_list)
    {
        if ($row['channel'] != 'ALL') {
            return false;
        }

        foreach ($key_list as $key) {
            if ($exclude_row[$key] != $row[$key]) {
                return false;
            }
        }

        return true;
    }

    private function adjustAllChannelRow(
        &$all_channel_row, $exclude_row,
        $adjust_field_list, $adjust_percent_field_list)
    {
        foreach ($adjust_percent_field_list as
                 $percent_field => $base_field) {
            $diff_base_field =
                $all_channel_row[$base_field] - $exclude_row[$base_field];
            $diff_percent_filed =
                $all_channel_row[$base_field] * $all_channel_row[$percent_field] -
                $exclude_row[$base_field] * $exclude_row[$percent_field];

            $all_channel_row[$percent_field] = ($diff_base_field == 0) ? 0 :
                $diff_percent_filed / $diff_base_field;
        }

        foreach ($adjust_field_list as $adjust_field) {
            $all_channel_row[$adjust_field] -= $exclude_row[$adjust_field];
        }
    }

    private function channelFilter($data_set, $key_list,
        $adjust_field_list, $adjust_percent_field_list)
    {
        if ($this->getAccountExcludeChannel() == '') {
            return $data_set;
        }

        $exclude_channel_list =
            explode(';', $this->getAccountExcludeChannel());

        $count = count($data_set);
        for ($i = 0; $i < $count; ++$i) {
            // check in exclude channel list
            if (in_array($data_set[$i]['channel'],
                         $exclude_channel_list, false) === false) {
                continue;
            }

            // adjust channel `all` data
            foreach ($data_set as &$row) {
                if ($this->isSameKeyAllChannelRow(
                        $row, $data_set[$i], $key_list)) {
                    $this->adjustAllChannelRow(
                        $row, $data_set[$i],
                        $adjust_field_list,
                        $adjust_percent_field_list);
                    break;
                }
            }

            // delete exclude channel data
            unset($data_set[$i]);
        }

        return array_values($data_set);
    }

    public function onlinePlayerAction()
    {
    }

    public function allOnlinePlayerAction()
    {
    }

    public function levelDistributionAction()
    {
    }

    public function resourceChangeAction()
    {
    }

    public function platformResourceChangeAction()
    {
    }

    public function hourlyReportAction()
    {
    }

    public function dailyReportAction()
    {
    }

    public function allDailyReportAction()
    {
    }

    public function allDailyReportOneDayAction()
    {
    }

    public function allDailyReportOneDayServerAction()
    {
    }

    public function monthlyReportAction()
    {
    }

    public function allMonthlyReportAction()
    {
    }

    public function weeklyReportAction()
    {
    }

    public function allWeeklyReportAction()
    {
    }

    public function allTmallDailyReportAction()
    {
    }
    
	public function allTmallWeeklyReportAction()
    {
    }

    public function allTmallMonthlyReportAction()
    {
    }

    public function allCpsDailyReportAction()
    {
    }

    public function allCpsMonthlyReportAction()
    {
    }

    public function spreadDailyReportAction()
    {
    }

    public function spreadAllDailyReportAction()
    {
    }

    public function spreadAllDailyReportOneDayAction()
    {
    }

    public function spreadMonthlyReportAction()
    {
    }

    public function spreadAllMonthlyReportAction()
    {
    }

    public function getOnlinePlayerAction()
    {
        $this->view->disable();

        // check auth
        if ($this->hasAuth(AccountType::ADVANCED_GM) == false) {
            return $this->error('not allowed');
        }

        // get params
        $server_id = $this->request->get('server_id');
        if ($server_id === null) {
            return $this->error('`server_id` is required');
        }
        $query_date = $this->request->get('query_date');
        if ($query_date === null) {
            return $this->error('`query_date` is required');
        }

        // check server id
        $server_model = $this->getVisableServerModel($server_id);
        if ($server_model === false) {
            return $this->error('`server_id` is invalid');
        }

        $ret = $this->slaveServerRequest(
            $server_model->addr, $server_model->secret_key,
            '/online_player.php', array(
                'query_date' => $query_date,
            ));
        if ($ret === false) {
            return $this->error('request slave server failed');
        }

        if (isset($ret['error_code'])) {
            return $this->success($ret);
        }

        return $this->success(array(
            'online_player' => $ret,
        ));
    }

    public function getAllOnlinePlayerAction()
    {
        $this->view->disable();

        // check auth
        if ($this->hasAuth(AccountType::ADVANCED_GM) == false) {
            return $this->error('not allowed');
        }

        $query_date = $this->request->get('query_date');
        if ($query_date === null) {
            return $this->error('`query_date` is required');
        }

        $request_list = array();
        $server_model_list = $this->getVisableServerModelList();
        foreach ($server_model_list as $server_model) {
            array_push($request_list, array(
                'addr' => $server_model->addr,
                'secret_key' => $server_model->secret_key,
                'uri' => '/online_player.php',
                'params' => array(
                    'query_date' => $query_date,
                ),
            ));
        }
        $ret_list = $this->multiSlaveServerRequest($request_list);

        $all_online_player = array();
        $max_normalize_time = 0;
        foreach ($ret_list as $ret) {
            if ($ret === false) {
                continue;
            }
            if (isset($ret['error_code'])) {
                continue;
            }

            foreach ($ret as $row) {
                $normalize_time = $row['time'] - $row['time'] % 5;
                if (isset($all_online_player[$normalize_time]) === false) {
                    $all_online_player[$normalize_time] = 0;
                }
                $all_online_player[$normalize_time] += $row['online_player'];

                if ($normalize_time > $max_normalize_time) {
                    $max_normalize_time = $normalize_time;
                }
            }
        }

        $ret = array();
        for ($i = 0; $i < $max_normalize_time; $i += 5) {
            $item = array();
            $item['time'] = $i;
            $item['online_player'] = isset($all_online_player[$item['time']])
                ? $all_online_player[$item['time']] : 0;
            array_push($ret, $item);
        }

        return $this->success(array(
            'all_online_player' => $ret,
        ));
    }

    public function getLevelDistributionAction()
    {
        $this->view->disable();

        // check auth
        if ($this->hasAuth(AccountType::ADVANCED_GM) == false) {
            return $this->error('not allowed');
        }

        // get params
        $server_id = $this->request->get('server_id');
        if ($server_id === null) {
            return $this->error('`server_id` is required');
        }
        $start_date = $this->request->get('start_date');
        if ($start_date === null) {
            return $this->error('`start_date` is required');
        }
        $end_date = $this->request->get('end_date');
        if ($end_date === null) {
            return $this->error('`end_date` is required');
        }

        // check server id
        $server_model = $this->getVisableServerModel($server_id);
        if ($server_model === false) {
            return $this->error('`server_id` is invalid');
        }

        $ret = $this->slaveServerRequest(
            $server_model->addr, $server_model->secret_key,
            '/level_distribution.php', array(
                'start_date' => $start_date,
                'end_date' => $end_date,
            ));
        if ($ret === false) {
            return $this->error('request slave server failed');
        }

        if (isset($ret['error_code'])) {
            return $this->success($ret);
        }

        $sum_player_number = 0;
        foreach ($ret as $row) {
            $sum_player_number += $row['player_number'];
        }
        $relative_sum_player_number = $sum_player_number;

        foreach ($ret as &$row) {
            $row['player_number_percent'] = sprintf('%.2f%%',
                $row['player_number'] * 100.0 / $sum_player_number);
            $row['player_number_relative_percent'] = sprintf('%.2f%%',
                $row['player_number'] * 100.0 / $relative_sum_player_number);

            $relative_sum_player_number -= $row['player_number'];
        }

        return $this->success(array(
            'level_distribution' => $ret,
        ));
    }

    public function getResourceChangeAction()
    {
        $this->view->disable();

        // check auth
        if ($this->hasAuth(AccountType::ADVANCED_GM) == false) {
            return $this->error('not allowed');
        }

        // get params
        $server_id = $this->request->get('server_id');
        if ($server_id === null) {
            return $this->error('`server_id` is required');
        }
        $query_date = $this->request->get('query_date');
        if ($query_date === null) {
            return $this->error('`query_date` is required');
        }
        $resource_id = $this->request->get('resource_id');
        if ($resource_id === null) {
            return $this->error('`resource_id` is required');
        }

        // check server id
        $server_model = $this->getVisableServerModel($server_id);
        if ($server_model === false) {
            return $this->error('`server_id` is invalid');
        }

        $ret = $this->slaveServerRequest(
            $server_model->addr, $server_model->secret_key,
            '/resource_change.php', array(
                'query_date' => $query_date,
                'resource_id' => $resource_id,
            ));
        if ($ret === false) {
            return $this->error('request slave server failed');
        }

        if (isset($ret['error_code'])) {
            return $this->success($ret);
        }

        $sum_production = 0;
        $sum_consumption = 0;
        foreach ($ret as $row) {
            $sum_production += $row['production'];
            $sum_consumption += $row['consumption'];
        }

        foreach ($ret as &$row) {
            $row['way_type'] = DataFormatter::wayType($row['way_type']);
            $row['production_percent'] = sprintf('%.2f%%',
                $row['production'] * 100.0 / $sum_production);
            $row['consumption_percent'] = sprintf('%.2f%%',
                $row['consumption'] * 100.0 / $sum_consumption);
        }

        array_push($ret, array(
            'way_type' => '总计',
            'production' => $sum_production,
            'consumption' => $sum_consumption,
            'production_percent' => '100.00%',
            'consumption_percent' => '100.00%',
        ));

        return $this->success(array(
            'resource_change_list' => $ret,
        ));
    }

    public function getPlatformResourceChangeAction()
    {
        $this->view->disable();

        // check auth
        if ($this->hasAuth(AccountType::ADVANCED_GM) == false) {
            return $this->error('not allowed');
        }

        // get params
        $platform_id = $this->request->get('platform_id');
        if ($platform_id === null) {
            return $this->error('`platform_id` is required');
        }
        $query_date = $this->request->get('query_date');
        if ($query_date === null) {
            return $this->error('`query_date` is required');
        }
        $resource_id = $this->request->get('resource_id');
        if ($resource_id === null) {
            return $this->error('`resource_id` is required');
        }

        $request_list = array();
        if ($platform_id == 0) {
            $server_model_list = $this->getVisableServerModelList();
        } else {
            $server_model_list = ServerModel::find(array(
                'conditions' => 'platform_id = :platform_id:',
                'bind' => array(
                    'platform_id' => $platform_id,
                ),
            ));
        }
        foreach ($server_model_list as $server_model) {
            array_push($request_list, array(
                'addr' => $server_model->addr,
                'secret_key' => $server_model->secret_key,
                'uri' => '/resource_change.php',
                'params' => array(
                    'query_date' => $query_date,
                    'resource_id' => $resource_id,
                ),
            ));
        }
        $ret_list = $this->multiSlaveServerRequest($request_list);

        $all_resource_change = array();
        $sum_production = 0;
        $sum_consumption = 0;
        foreach ($ret_list as $ret) {
            if ($ret === false) {
                continue;
            }
            if (isset($ret['error_code'])) {
                continue;
            }
            foreach ($ret as $row) {
                $index = $row['way_type'];
                if (isset($all_resource_change[$index]) === false) {
                    $item = array();
                    $item['way_type'] = $row['way_type'];
                    $item['production'] = 0;
                    $item['consumption'] = 0;
                    $all_resource_change[$index] = $item;
                }
                $sum_item = &$all_resource_change[$index];
                $sum_item['production'] += $row['production'];
                $sum_item['consumption'] += $row['consumption'];

                $sum_production += $row['production'];
                $sum_consumption += $row['consumption'];

                unset($sum_item);
            }
        }
        ksort($all_resource_change, SORT_STRING);
        $ret = array_values($all_resource_change);

        foreach ($ret as &$row) {
            $row['way_type'] = DataFormatter::wayType($row['way_type']);
            $row['production_percent'] = sprintf('%.2f%%',
                $row['production'] * 100.0 / $sum_production);
            $row['consumption_percent'] = sprintf('%.2f%%',
                $row['consumption'] * 100.0 / $sum_consumption);
        }

        array_push($ret, array(
            'way_type' => '总计',
            'production' => $sum_production,
            'consumption' => $sum_consumption,
            'production_percent' => '100.00%',
            'consumption_percent' => '100.00%',
        ));

        return $this->success(array(
            'resource_change_list' => $ret,
        ));
    }

    public function getHourlyReportAction()
    {
        $this->view->disable();

        // check auth
        if ($this->hasAuth(AccountType::ADVANCED_GM) == false) {
            return $this->error('not allowed');
        }
        // get params
        $server_id = $this->request->get('server_id');
        if ($server_id === null) {
            return $this->error('`server_id` is required');
        }
        $query_date = $this->request->get('query_date');
        if ($query_date === null) {
            return $this->error('`query_date` is required');
        }

        // check server id
        $server_model = $this->getVisableServerModel($server_id);
        if ($server_model === false) {
            return $this->error('`server_id` is invalid');
        }

        $ret = $this->slaveServerRequest(
            $server_model->addr, $server_model->secret_key,
            '/hourly_report.php', array(
                'query_date' => $query_date,
            ));
        if ($ret === false) {
            return $this->error('request slave server failed');
        }

        if (isset($ret['error_code'])) {
            return $this->success($ret);
        }

        $ret = $this->channelFilter($ret,
            array('timestamp'),
            array('new_users', 'revenue', 'pay_times', 'pay_users'),
            array());

        foreach ($ret as &$row) {
            $row['channel'] =
                $this->getChannelDesc($row['channel']);
            $row['revenue'] = sprintf("%.2f",
                $row['revenue'] / 100.0);
        }

        return $this->success(array(
            'hourly_report_list' => $ret,
        ));
    }

    public function getDailyReportAction()
    {
        $this->view->disable();

        // check auth
        if ($this->hasAuth(AccountType::ADVANCED_GM) == false) {
            return $this->error('not allowed');
        }

        // get params
        $server_id = $this->request->get('server_id');
        if ($server_id === null) {
            return $this->error('`server_id` is required');
        }
        $start_date = $this->request->get('start_date');
        if ($start_date === null) {
            return $this->error('`start_date` is required');
        }
        $end_date = $this->request->get('end_date');
        if ($end_date === null) {
            return $this->error('`end_date` is required');
        }

        // check server id
        $server_model = $this->getVisableServerModel($server_id);
        if ($server_model === false) {
            return $this->error('`server_id` is invalid');
        }

        $ret = $this->slaveServerRequest(
            $server_model->addr, $server_model->secret_key,
            '/daily_report.php', array(
                'start_date' => $start_date,
                'end_date' => $end_date,
            ));
        if ($ret === false) {
            return $this->error('request slave server failed');
        }

        if (isset($ret['error_code'])) {
            return $this->success($ret);
        }

        $ret = $this->channelFilter($ret,
            array('timestamp'),
            array(
                'daily_new_users',
                'daily_one_session_users',
                'daily_active_users',
                'new_user_login_times',
                'old_user_login_times',
                'daily_revenue',
                'daily_pay_times',
                'daily_pay_users',
                'total_pay_users',
                'new_pay_users',
                'daily_new_user_revenue',
                'daily_new_user_pay_times',
                'daily_new_user_pay_users',
            ),
            array(
                'daily_avg_online_time' => 'daily_active_users',
                'day1_retention_ratio' => 'daily_new_users',
                'day2_retention_ratio' => 'daily_new_users',
                'day3_retention_ratio' => 'daily_new_users',
                'day4_retention_ratio' => 'daily_new_users',
                'day5_retention_ratio' => 'daily_new_users',
                'day6_retention_ratio' => 'daily_new_users',
                'day7_retention_ratio' => 'daily_new_users',
                'day14_retention_ratio' => 'daily_new_users',
                'day15_retention_ratio' => 'daily_new_users',
                'day29_retention_ratio' => 'daily_new_users',
                'day30_retention_ratio' => 'daily_new_users',
                'daily_arpu' => 'daily_active_users',
                'daily_arppu' => 'daily_pay_users',
            ));

        foreach ($ret as &$row) {
            $row['channel'] =
                $this->getChannelDesc($row['channel']);
            $row['daily_avg_online_time'] =
                (int)($row['daily_avg_online_time'] / 60);
            $row['daily_active_old_users'] =
                $row['daily_active_users'] - $row['daily_new_users'];
            $row['day1_retention_ratio'] = sprintf("%.2f%%",
                $row['day1_retention_ratio'] / 100.0);
            $row['day2_retention_ratio'] = sprintf("%.2f%%",
                $row['day2_retention_ratio'] / 100.0);
            $row['day3_retention_ratio'] = sprintf("%.2f%%",
                $row['day3_retention_ratio'] / 100.0);
            $row['day4_retention_ratio'] = sprintf("%.2f%%",
                $row['day4_retention_ratio'] / 100.0);
            $row['day5_retention_ratio'] = sprintf("%.2f%%",
                $row['day5_retention_ratio'] / 100.0);
            $row['day6_retention_ratio'] = sprintf("%.2f%%",
                $row['day6_retention_ratio'] / 100.0);
            $row['day7_retention_ratio'] = sprintf("%.2f%%",
                $row['day7_retention_ratio'] / 100.0);
            $row['day14_retention_ratio'] = sprintf("%.2f%%",
                $row['day14_retention_ratio'] / 100.0);
            $row['day15_retention_ratio'] = sprintf("%.2f%%",
                $row['day15_retention_ratio'] / 100.0);
            $row['day29_retention_ratio'] = sprintf("%.2f%%",
                $row['day29_retention_ratio'] / 100.0);
            $row['day30_retention_ratio'] = sprintf("%.2f%%",
                $row['day30_retention_ratio'] / 100.0);
            $row['daily_revenue'] = sprintf("%.2f",
                $row['daily_revenue'] / 100.0);
            $row['daily_pay_rate'] = sprintf("%.2f%%",
                $row['daily_active_users'] > 0 
                ? $row['daily_pay_users'] * 100.0 / $row['daily_active_users']
                : 0);
            $row['daily_arpu'] = sprintf("%.2f",
                $row['daily_arpu'] / 100.0);
            $row['daily_arppu'] = sprintf("%.2f",
                $row['daily_arppu'] / 100.0);
            $row['daily_new_user_revenue'] = sprintf("%.2f",
                $row['daily_new_user_revenue'] / 100.0);
            $row['daily_new_user_pay_rate'] = sprintf("%.2f%%",
                $row['daily_new_users'] > 0
                ? $row['daily_new_user_pay_users'] * 100.0 /
                  $row['daily_new_users']
                : 0);
        }

        return $this->success(array(
            'daily_report_list' => $ret,
        ));
    }

    public function getAllDailyReportAction()
    {
        $this->view->disable();

        // check auth
        if ($this->hasAuth(AccountType::ADVANCED_GM) == false) {
            return $this->error('not allowed');
        }

        // get params
        $start_date = $this->request->get('start_date');
        if ($start_date === null) {
            return $this->error('`start_date` is required');
        }
        $end_date = $this->request->get('end_date');
        if ($end_date === null) {
            return $this->error('`end_date` is required');
        }
        $channel = $this->request->get('channel');
        if ($channel === null) {
            return $this->error('`channel` is required');
        }

        $request_list = array();
        $server_model_list = $this->getVisableServerModelList();
        foreach ($server_model_list as $server_model) {
            array_push($request_list, array(
                'addr' => $server_model->addr,
                'secret_key' => $server_model->secret_key,
                'uri' => '/daily_report.php',
                'params' => array(
                    'start_date' => $start_date,
                    'end_date' => $end_date,
                ),
            ));
        }
        $ret_list = $this->multiSlaveServerRequest($request_list);

        $day_list = array(1, 2, 3, 4, 5, 6, 7, 14, 15, 29, 30);
        $all_daily_report = array();
        foreach ($ret_list as $ret) {
            if ($ret === false) {
                continue;
            }
            if (isset($ret['error_code'])) {
                continue;
            }

            $ret = $this->channelFilter($ret,
                array('timestamp'),
                array(
                    'daily_new_users',
                    'daily_one_session_users',
                    'daily_active_users',
                    'daily_active_pay_users',
                    'new_user_login_times',
                    'old_user_login_times',
                    'daily_revenue',
                    'daily_pay_times',
                    'daily_pay_users',
                    'total_pay_users',
                    'new_pay_users',
                    'daily_new_user_revenue',
                    'daily_new_user_pay_times',
                    'daily_new_user_pay_users',
                ),
                array(
                    'daily_avg_online_time' => 'daily_active_users',
                    'day1_retention_ratio' => 'daily_new_users',
                    'day2_retention_ratio' => 'daily_new_users',
                    'day3_retention_ratio' => 'daily_new_users',
                    'day4_retention_ratio' => 'daily_new_users',
                    'day5_retention_ratio' => 'daily_new_users',
                    'day6_retention_ratio' => 'daily_new_users',
                    'day7_retention_ratio' => 'daily_new_users',
                    'day14_retention_ratio' => 'daily_new_users',
                    'day15_retention_ratio' => 'daily_new_users',
                    'day29_retention_ratio' => 'daily_new_users',
                    'day30_retention_ratio' => 'daily_new_users',
                    'daily_arpu' => 'daily_active_users',
                    'daily_arppu' => 'daily_pay_users',
                ));

            foreach ($ret as $row) {
                if ($channel !== '' &&
                    $row['channel'] !== $channel) {
                    continue;
                }

                // `all channel` need to be the last one
                if ($row['channel'] === 'ALL') {
                    $index = $row['timestamp'].'9999999';
                } else {
                    $index = $row['timestamp'].$row['channel'];
                }
                if (isset($all_daily_report[$index]) === false) {
                    $item = array();
                    $item['timestamp'] = $row['timestamp'];
                    $item['channel'] =
                        $this->getChannelDesc($row['channel']);
                    $item['daily_new_users'] = 0;
                    $item['daily_active_users'] = 0;
                    $item['daily_active_pay_users'] = 0;
                    $item['daily_revenue'] = 0;
                    $item['daily_pay_times'] = 0;
                    $item['daily_pay_users'] = 0;
                    $item['total_pay_users'] = 0;
                    $item['new_pay_users'] = 0;
                    $item['daily_new_user_revenue'] = 0;
                    $item['daily_new_user_pay_times'] = 0;
                    $item['daily_new_user_pay_users'] = 0;
                    $item['new_user_login_times'] = 0;
                    $item['old_user_login_times'] = 0;
                    $item['daily_avg_online_time'] = 0;
                    foreach ($day_list as $day) {
                        $item["day${day}_retention_ratio"] = 0;
                    }
                    $all_daily_report[$index] = $item;
                }
                $sum_item = &$all_daily_report[$index];

                $sum_item['daily_new_users'] +=
                    $row['daily_new_users'];
                $sum_item['daily_active_users'] +=
                    $row['daily_active_users'];
                $sum_item['daily_active_pay_users'] +=
                    $row['daily_active_pay_users'];
                $sum_item['daily_revenue'] +=
                    $row['daily_revenue'];
                $sum_item['daily_pay_times'] +=
                    $row['daily_pay_times'];
                $sum_item['daily_pay_users'] +=
                    $row['daily_pay_users'];
                $sum_item['total_pay_users'] +=
                    $row['total_pay_users'];
                $sum_item['new_pay_users'] +=
                    $row['new_pay_users'];
                $sum_item['daily_new_user_revenue'] +=
                    $row['daily_new_user_revenue'];
                $sum_item['daily_new_user_pay_times'] +=
                    $row['daily_new_user_pay_times'];
                $sum_item['daily_new_user_pay_users'] +=
                    $row['daily_new_user_pay_users'];
                $sum_item['new_user_login_times'] +=
                    $row['new_user_login_times'];
                $sum_item['old_user_login_times'] +=
                    $row['old_user_login_times'];
                $sum_item['production'] +=
                    $row['production'];
                $sum_item['consumption'] +=
                    $row['consumption'];
                $sum_item['daily_avg_online_time'] +=
                    $row['daily_avg_online_time'] * $row['daily_active_users'];
                foreach ($day_list as $day) {
                    $sum_item["day${day}_retention_ratio"] +=
                        $row["day${day}_retention_ratio"] *
                        $row['daily_new_users'];
                }

                unset($sum_item);
            }
        }

        ksort($all_daily_report, SORT_STRING);
        $ret = array_values($all_daily_report);

        foreach ($ret as &$row) {
            $row['daily_active_old_users'] =
                $row['daily_active_users'] - $row['daily_new_users'];
            $row['daily_revenue'] = sprintf("%.2f",
                $row['daily_revenue'] / 100.0);
            $row['daily_pay_rate'] = sprintf("%.2f%%",
                $row['daily_active_users'] > 0
                ? $row['daily_pay_users'] * 100.0 / $row['daily_active_users']
                : 0);
            $row['daily_new_user_revenue'] = sprintf("%.2f",
                $row['daily_new_user_revenue'] / 100.0);
            $row['daily_new_user_pay_rate'] = sprintf("%.2f%%",
                $row['daily_new_users'] > 0
                ? $row['daily_new_user_pay_users'] * 100.0 /
                  $row['daily_new_users']
                : 0);
            $row['daily_arpu'] = sprintf("%.2f",
                $row['daily_active_users'] > 0
                ? $row['daily_revenue'] / $row['daily_active_users']
                : 0);
            $row['daily_arppu'] = sprintf("%.2f",
                $row['daily_pay_users'] > 0
                ? $row['daily_revenue'] / $row['daily_pay_users']
                : 0);
            $row['daily_avg_online_time'] = sprintf("%d",
                $row['daily_active_users'] > 0
                ? (int)($row['daily_avg_online_time'] / 60 /
                        $row['daily_active_users'])
                : 0);
            foreach ($day_list as $day) {
                $row["day${day}_retention_ratio"] = sprintf("%.2f%%",
                    $row['daily_new_users'] > 0
                    ? $row["day${day}_retention_ratio"] /
                      $row['daily_new_users'] / 100.0
                    : 0);
            }
        }

        return $this->success(array(
            'all_daily_report_list' => $ret,
        ));
    }

    public function getAllDailyReportOneDayServerAction()
    {
        $this->view->disable();

        // check auth
        if ($this->hasAuth(AccountType::ADVANCED_GM) == false) {
            return $this->error('not allowed');
        }

        // get params
        $query_date = $this->request->get('query_date');
        if ($query_date === null) {
            return $this->error('`query_date` is required');
        }

        $request_list = array();
        $server_info_list = array();
        $server_model_list = $this->getVisableServerModelList();
        foreach ($server_model_list as $server_model) {
            array_push($request_list, array(
                'addr' => $server_model->addr,
                'secret_key' => $server_model->secret_key,
                'uri' => '/daily_report.php',
                'params' => array(
                    'start_date' => $query_date,
                    'end_date' => $query_date,
                ),
            ));
            array_push($server_info_list, array(
                'server_name' => $server_model->desc,
            ));
        }
        $ret_list = $this->multiSlaveServerRequest($request_list);

        $all_daily_report = array();
        for ($i = 0; $i < count($ret_list); ++$i) {
            $ret = $ret_list[$i];
            $server_info = $server_info_list[$i];

            if ($ret === false) {
                continue;
            }
            if (isset($ret['error_code'])) {
                continue;
            }

            $ret = $this->channelFilter($ret,
                array('timestamp'),
                array(
                    'daily_new_users',
                    'daily_one_session_users',
                    'daily_active_users',
                    'new_user_login_times',
                    'old_user_login_times',
                    'daily_revenue',
                    'daily_pay_times',
                    'daily_pay_users',
                    'total_pay_users',
                    'new_pay_users',
                    'daily_new_user_revenue',
                    'daily_new_user_pay_times',
                    'daily_new_user_pay_users',
                ),
                array(
                    'daily_avg_online_time' => 'daily_active_users',
                    'day1_retention_ratio' => 'daily_new_users',
                    'day2_retention_ratio' => 'daily_new_users',
                    'day3_retention_ratio' => 'daily_new_users',
                    'day4_retention_ratio' => 'daily_new_users',
                    'day5_retention_ratio' => 'daily_new_users',
                    'day6_retention_ratio' => 'daily_new_users',
                    'day7_retention_ratio' => 'daily_new_users',
                    'day14_retention_ratio' => 'daily_new_users',
                    'day15_retention_ratio' => 'daily_new_users',
                    'day29_retention_ratio' => 'daily_new_users',
                    'day30_retention_ratio' => 'daily_new_users',
                    'daily_arpu' => 'daily_active_users',
                    'daily_arppu' => 'daily_pay_users',
                ));

            foreach ($ret as $row) {
                if ($row['channel'] !== 'ALL') {
                    continue;
                }
                array_push($all_daily_report,
                    array_merge($row, $server_info));
            }
        }

        foreach ($all_daily_report as &$row) {
            $row['daily_avg_online_time'] =
                (int)($row['daily_avg_online_time'] / 60);
            $row['daily_active_old_users'] =
                $row['daily_active_users'] - $row['daily_new_users'];
            $row['daily_revenue'] = sprintf("%.2f",
                $row['daily_revenue'] / 100.0);
            $row['daily_pay_rate'] = sprintf("%.2f%%",
                $row['daily_active_users'] > 0 
                ? $row['daily_pay_users'] * 100.0 / $row['daily_active_users']
                : 0);
            $row['daily_arpu'] = sprintf("%.2f",
                $row['daily_arpu'] / 100.0);
            $row['daily_arppu'] = sprintf("%.2f",
                $row['daily_arppu'] / 100.0);
            $row['daily_new_user_revenue'] = sprintf("%.2f",
                $row['daily_new_user_revenue'] / 100.0);
            $row['daily_new_user_pay_rate'] = sprintf("%.2f%%",
                $row['daily_new_users'] > 0
                ? $row['daily_new_user_pay_users'] * 100.0 /
                  $row['daily_new_users']
                : 0);
        }

        return $this->success(array(
            'all_daily_report_list' => $all_daily_report,
        ));
    }

    public function getMonthlyReportAction()
    {
        $this->view->disable();

        // check auth
        if ($this->hasAuth(AccountType::ADVANCED_GM) == false) {
            return $this->error('not allowed');
        }

        // get params
        $server_id = $this->request->get('server_id');
        if ($server_id === null) {
            return $this->error('`server_id` is required');
        }

        // check server id
        $server_model = $this->getVisableServerModel($server_id);
        if ($server_model === false) {
            return $this->error('`server_id` is invalid');
        }

        $ret = $this->slaveServerRequest(
            $server_model->addr, $server_model->secret_key,
            '/monthly_report.php');
        if ($ret === false) {
            return $this->error('request slave server failed');
        }

        if (isset($ret['error_code'])) {
            return $this->success($ret);
        }

        $ret = $this->channelFilter($ret,
            array('timestamp'),
            array(
                'monthly_new_users',
                'monthly_active_users',
                'monthly_revenue',
                'monthly_pay_times',
                'monthly_pay_users',
            ),
            array(
                'monthly_arpu' => 'monthly_active_users',
                'monthly_arppu' => 'monthly_pay_users',
            ));

        foreach ($ret as &$row) {
            $row['channel'] =
                $this->getChannelDesc($row['channel']);
            $row['monthly_revenue'] = sprintf("%.2f",
                $row['monthly_revenue'] / 100.0);
            $row['monthly_pay_rate'] = sprintf("%.2f%%",
                $row['monthly_active_users'] > 0 
                ? $row['monthly_pay_users'] * 100.0 /
                      $row['monthly_active_users']
                : 0);
            $row['monthly_arpu'] = sprintf("%.2f",
                $row['monthly_arpu'] / 100.0);
            $row['monthly_arppu'] = sprintf("%.2f",
                $row['monthly_arppu'] / 100.0);
        }

        return $this->success(array(
            'monthly_report_list' => $ret,
        ));
    }

    public function getAllMonthlyReportAction()
    {
        $this->view->disable();

        // check auth
        if ($this->hasAuth(AccountType::ADVANCED_GM) == false) {
            return $this->error('not allowed');
        }

        $request_list = array();
        $server_model_list = $this->getVisableServerModelList();
        foreach ($server_model_list as $server_model) {
            array_push($request_list, array(
                'addr' => $server_model->addr,
                'secret_key' => $server_model->secret_key,
                'uri' => '/monthly_report.php',
            ));
        }
        $ret_list = $this->multiSlaveServerRequest($request_list);

        $all_monthly_report = array();
        foreach ($ret_list as $ret) {
            if ($ret === false) {
                continue;
            }
            if (isset($ret['error_code'])) {
                continue;
            }

            $ret = $this->channelFilter($ret,
                array('timestamp'),
                array(
                    'monthly_new_users',
                    'monthly_active_users',
                    'monthly_revenue',
                    'monthly_pay_times',
                    'monthly_pay_users',
                ),
                array(
                    'monthly_arpu' => 'monthly_active_users',
                    'monthly_arppu' => 'monthly_pay_users',
                ));

            foreach ($ret as $row) {
                // `all channel` need to be the last one
                if ($row['channel'] === 'ALL') {
                    $index = $row['timestamp'].'9999999';
                } else {
                    $index = $row['timestamp'].$row['channel'];
                }
                if (isset($all_monthly_report[$index]) === false) {
                    $item = array();
                    $item['index'] = $index;
                    $item['timestamp'] = $row['timestamp'];
                    $item['channel'] =
                        $this->getChannelDesc($row['channel']);
                    $item['monthly_new_users'] = 0;
                    $item['monthly_active_users'] = 0;
                    $item['monthly_revenue'] = 0;
                    $item['monthly_pay_times'] = 0;
                    $item['monthly_pay_users'] = 0;
                    $all_monthly_report[$index] = $item;
                }
                $sum_item = &$all_monthly_report[$index];

                $sum_item['monthly_new_users'] +=
                    $row['monthly_new_users'];
                $sum_item['monthly_active_users'] +=
                    $row['monthly_active_users'];
                $sum_item['monthly_revenue'] +=
                    $row['monthly_revenue'];
                $sum_item['monthly_pay_times'] +=
                    $row['monthly_pay_times'];
                $sum_item['monthly_pay_users'] +=
                    $row['monthly_pay_users'];

                unset($sum_item);
            }
        }

        ksort($all_monthly_report, SORT_STRING);
        $ret = array_values($all_monthly_report);

        foreach ($ret as &$row) {
            $row['monthly_revenue'] = sprintf("%.2f",
                $row['monthly_revenue'] / 100.0);
            $row['monthly_pay_rate'] = sprintf("%.2f%%",
                $row['monthly_active_users'] > 0 
                ? $row['monthly_pay_users'] * 100.0 /
                      $row['monthly_active_users']
                : 0);
            $row['monthly_arpu'] = sprintf("%.2f",
                $row['monthly_active_users'] > 0
                ? $row['monthly_revenue'] / $row['monthly_active_users']
                : 0);
            $row['monthly_arppu'] = sprintf("%.2f",
                $row['monthly_pay_users'] > 0
                ? $row['monthly_revenue'] / $row['monthly_pay_users']
                : 0);
        }

        return $this->success(array(
            'all_monthly_report_list' => $ret,
        ));
    }

    public function getWeeklyReportAction()
    {
        $this->view->disable();

        // check auth
        if ($this->hasAuth(AccountType::ADVANCED_GM) == false) {
            return $this->error('not allowed');
        }

        // get params
        $server_id = $this->request->get('server_id');
        if ($server_id === null) {
            return $this->error('`server_id` is required');
        }

        // check server id
        $server_model = $this->getVisableServerModel($server_id);
        if ($server_model === false) {
            return $this->error('`server_id` is invalid');
        }

        $ret = $this->slaveServerRequest(
            $server_model->addr, $server_model->secret_key,
            '/weekly_report.php');
        if ($ret === false) {
            return $this->error('request slave server failed');
        }

        if (isset($ret['error_code'])) {
            return $this->success($ret);
        }

        $ret = $this->channelFilter($ret,
            array('timestamp'),
            array(
                'weekly_active_users',
                'weekly_revenue',
                'weekly_pay_times',
                'weekly_pay_users',
            ),
            array(
                'weekly_arpu' => 'weekly_active_users',
                'weekly_arppu' => 'weekly_pay_users',
            ));

        foreach ($ret as &$row) {
            $row['channel'] =
                $this->getChannelDesc($row['channel']);
            $row['weekly_revenue'] = sprintf("%.2f",
                $row['weekly_revenue'] / 100.0);
            $row['weekly_pay_rate'] = sprintf("%.2f%%",
                $row['weekly_active_users'] > 0 
                ? $row['weekly_pay_users'] * 100.0 /
                      $row['weekly_active_users']
                : 0);
            $row['weekly_arpu'] = sprintf("%.2f",
                $row['weekly_arpu'] / 100.0);
            $row['weekly_arppu'] = sprintf("%.2f",
                $row['weekly_arppu'] / 100.0);
        }

        return $this->success(array(
            'weekly_report_list' => $ret,
        ));
    }

    public function getAllWeeklyReportAction()
    {
        $this->view->disable();

        // check auth
        if ($this->hasAuth(AccountType::ADVANCED_GM) == false) {
            return $this->error('not allowed');
        }

        $request_list = array();
        $server_model_list = $this->getVisableServerModelList();
        foreach ($server_model_list as $server_model) {
            array_push($request_list, array(
                'addr' => $server_model->addr,
                'secret_key' => $server_model->secret_key,
                'uri' => '/weekly_report.php',
            ));
        }
        $ret_list = $this->multiSlaveServerRequest($request_list);

        $all_weekly_report = array();
        foreach ($ret_list as $ret) {
            if ($ret === false) {
                continue;
            }
            if (isset($ret['error_code'])) {
                continue;
            }

            $ret = $this->channelFilter($ret,
                array('timestamp'),
                array(
                    'weekly_new_users',
                    'weekly_active_users',
                    'weekly_revenue',
                    'weekly_pay_times',
                    'weekly_pay_users',
                ),
                array(
                    'weekly_arpu' => 'weekly_active_users',
                    'weekly_arppu' => 'weekly_pay_users',
                ));

            foreach ($ret as $row) {
                // `all channel` need to be the last one
                if ($row['channel'] === 'ALL') {
                    $index = $row['timestamp'].'9999999';
                } else {
                    $index = $row['timestamp'].$row['channel'];
                }
                if (isset($all_weekly_report[$index]) === false) {
                    $item = array();
                    $item['index'] = $index;
                    $item['timestamp'] = $row['timestamp'];
                    $item['channel'] =
                        $this->getChannelDesc($row['channel']);
                    $item['weekly_new_users'] = 0;
                    $item['weekly_active_users'] = 0;
                    $item['weekly_revenue'] = 0;
                    $item['weekly_pay_times'] = 0;
                    $item['weekly_pay_users'] = 0;
                    $all_weekly_report[$index] = $item;
                }
                $sum_item = &$all_weekly_report[$index];

                $sum_item['weekly_new_users'] +=
                    $row['weekly_new_users'];
                $sum_item['weekly_active_users'] +=
                    $row['weekly_active_users'];
                $sum_item['weekly_revenue'] +=
                    $row['weekly_revenue'];
                $sum_item['weekly_pay_times'] +=
                    $row['weekly_pay_times'];
                $sum_item['weekly_pay_users'] +=
                    $row['weekly_pay_users'];

                unset($sum_item);
            }
        }

        ksort($all_weekly_report, SORT_STRING);
        $ret = array_values($all_weekly_report);

        foreach ($ret as &$row) {
            $row['weekly_revenue'] = sprintf("%.2f",
                $row['weekly_revenue'] / 100.0);
            $row['weekly_pay_rate'] = sprintf("%.2f%%",
                $row['weekly_active_users'] > 0 
                ? $row['weekly_pay_users'] * 100.0 /
                      $row['weekly_active_users']
                : 0);
            $row['weekly_arpu'] = sprintf("%.2f",
                $row['weekly_active_users'] > 0
                ? $row['weekly_revenue'] / $row['weekly_active_users']
                : 0);
            $row['weekly_arppu'] = sprintf("%.2f",
                $row['weekly_pay_users'] > 0
                ? $row['weekly_revenue'] / $row['weekly_pay_users']
                : 0);
        }

        return $this->success(array(
            'all_weekly_report_list' => $ret,
        ));
    }

    public function getAllTmallDailyReportAction()
    {
        $this->view->disable();

        // check auth
        if ($this->hasAuth(AccountType::ADMIN) == false) {
            return $this->error('not allowed');
        }

        // get params
        $start_date = $this->request->get('start_date');
        if ($start_date === null) {
            return $this->error('`start_date` is required');
        }
        $end_date = $this->request->get('end_date');
        if ($end_date === null) {
            return $this->error('`end_date` is required');
        }

        $request_list = array();
        $server_model_list = $this->getVisableServerModelList();
        foreach ($server_model_list as $server_model) {
            array_push($request_list, array(
                'addr' => $server_model->addr,
                'secret_key' => $server_model->secret_key,
                'uri' => '/tmall_daily_report.php',
                'params' => array(
                    'start_date' => $start_date,
                    'end_date' => $end_date,
                ),
            ));
        }
        $ret_list = $this->multiSlaveServerRequest($request_list);

        $all_daily_report = array();
        foreach ($ret_list as $ret) {
            if ($ret === false) {
                continue;
            }
            if (isset($ret['error_code'])) {
                continue;
            }

            foreach ($ret as $row) {

                // `all channel` need to be the last one
                if ($row['channel'] === 'ALL') {
                    $index = $row['timestamp'].'9999999';
                } else {
                    $index = $row['timestamp'].$row['channel'];
                }
                if (isset($all_daily_report[$index]) === false) {
                    $item = array();
                    $item['timestamp'] = $row['timestamp'];
                    $item['channel'] =
                        $this->getChannelDesc($row['channel']);
                    $item['daily_new_users'] = 0;
                    $item['daily_revenue'] = 0;
                    $item['daily_pay_times'] = 0;
                    $item['daily_pay_users'] = 0;
                    $item['total_pay_users'] = 0;
                    $item['new_pay_users'] = 0;
                    $all_daily_report[$index] = $item;
                }
                $sum_item = &$all_daily_report[$index];

                $sum_item['daily_new_users'] +=
                    $row['daily_new_users'];
                $sum_item['daily_revenue'] +=
                    $row['daily_revenue'];
                $sum_item['daily_pay_times'] +=
                    $row['daily_pay_times'];
                $sum_item['daily_pay_users'] +=
                    $row['daily_pay_users'];
                $sum_item['total_pay_users'] +=
                    $row['total_pay_users'];
                $sum_item['new_pay_users'] +=
                    $row['new_pay_users'];

                unset($sum_item);
            }
        }

        ksort($all_daily_report, SORT_STRING);
        $ret = array_values($all_daily_report);

        foreach ($ret as &$row) {
            $row['daily_revenue'] = sprintf("%.2f",
                $row['daily_revenue'] / 100.0);
        }

        return $this->success(array(
            'all_tmall_daily_report_list' => $ret,
        ));
    }

	public function getAllTmallWeeklyReportAction()
    {
        $this->view->disable();

        // check auth
        if ($this->hasAuth(AccountType::ADMIN) == false) {
            return $this->error('not allowed');
        }

        $request_list = array();
        $server_model_list = $this->getVisableServerModelList();
        foreach ($server_model_list as $server_model) {
            array_push($request_list, array(
                'addr' => $server_model->addr,
                'secret_key' => $server_model->secret_key,
                'uri' => '/tmall_weekly_report.php',
            ));
        }
        $ret_list = $this->multiSlaveServerRequest($request_list);

        $all_weekly_report = array();
        foreach ($ret_list as $ret) {
            if ($ret === false) {
                continue;
            }
            if (isset($ret['error_code'])) {
                continue;
            }

            foreach ($ret as $row) {
                // `all channel` need to be the last one
                if ($row['channel'] === 'ALL') {
                    $index = $row['timestamp'].'9999999';
                } else {
                    $index = $row['timestamp'].$row['channel'];
                }
                if (isset($all_monthly_report[$index]) === false) {
                    $item = array();
                    $item['index'] = $index;
                    $item['timestamp'] = $row['timestamp'];
                    $item['channel'] =
                        $this->getChannelDesc($row['channel']);
                    $item['weekly_revenue'] = 0;
                    $item['weekly_pay_times'] = 0;
                    $item['weekly_pay_users'] = 0;
                    $all_weekly_report[$index] = $item;
                }
                $sum_item = &$all_weekly_report[$index];

                $sum_item['weekly_revenue'] +=
                    $row['weekly_revenue'];
                $sum_item['weekly_pay_times'] +=
                    $row['weekly_pay_times'];
                $sum_item['weekly_pay_users'] +=
                    $row['weekly_pay_users'];

                unset($sum_item);
            }
        }

        ksort($all_weekly_report, SORT_STRING);
        $ret = array_values($all_weekly_report);

        foreach ($ret as &$row) {
            $row['weekly_revenue'] = sprintf("%.2f",
                $row['weekly_revenue'] / 100.0);
        }

        return $this->success(array(
            'all_tmall_weekly_report_list' => $ret,
        ));
    }
    
	public function getAllTmallMonthlyReportAction()
    {
        $this->view->disable();

        // check auth
        if ($this->hasAuth(AccountType::ADMIN) == false) {
            return $this->error('not allowed');
        }

        $request_list = array();
        $server_model_list = $this->getVisableServerModelList();
        foreach ($server_model_list as $server_model) {
            array_push($request_list, array(
                'addr' => $server_model->addr,
                'secret_key' => $server_model->secret_key,
                'uri' => '/tmall_monthly_report.php',
            ));
        }
        $ret_list = $this->multiSlaveServerRequest($request_list);

        $all_monthly_report = array();
        foreach ($ret_list as $ret) {
            if ($ret === false) {
                continue;
            }
            if (isset($ret['error_code'])) {
                continue;
            }

            foreach ($ret as $row) {
                // `all channel` need to be the last one
                if ($row['channel'] === 'ALL') {
                    $index = $row['timestamp'].'9999999';
                } else {
                    $index = $row['timestamp'].$row['channel'];
                }
                if (isset($all_monthly_report[$index]) === false) {
                    $item = array();
                    $item['index'] = $index;
                    $item['timestamp'] = $row['timestamp'];
                    $item['channel'] =
                        $this->getChannelDesc($row['channel']);
                    $item['monthly_revenue'] = 0;
                    $item['monthly_pay_times'] = 0;
                    $item['monthly_pay_users'] = 0;
                    $all_monthly_report[$index] = $item;
                }
                $sum_item = &$all_monthly_report[$index];

                $sum_item['monthly_revenue'] +=
                    $row['monthly_revenue'];
                $sum_item['monthly_pay_times'] +=
                    $row['monthly_pay_times'];
                $sum_item['monthly_pay_users'] +=
                    $row['monthly_pay_users'];

                unset($sum_item);
            }
        }

        ksort($all_monthly_report, SORT_STRING);
        $ret = array_values($all_monthly_report);

        foreach ($ret as &$row) {
            $row['monthly_revenue'] = sprintf("%.2f",
                $row['monthly_revenue'] / 100.0);
        }

        return $this->success(array(
            'all_tmall_monthly_report_list' => $ret,
        ));
    }

    public function getAllCpsDailyReportAction()
    {
        $this->view->disable();

        // check auth
        if ($this->hasAuth(AccountType::GM) == false) {
            return $this->error('not allowed');
        }

        // get params
        $start_date = $this->request->get('start_date');
        if ($start_date === null) {
            return $this->error('`start_date` is required');
        }
        $end_date = $this->request->get('end_date');
        if ($end_date === null) {
            return $this->error('`end_date` is required');
        }
        
        $account_cps = $this->getAccountCps();
        $account_cps = ($account_cps == '' ? 'ALL' : $account_cps);

        $request_list = array();
        $server_model_list = $this->getVisableServerModelList();
        foreach ($server_model_list as $server_model) {
            array_push($request_list, array(
                'addr' => $server_model->addr,
                'secret_key' => $server_model->secret_key,
                'uri' => '/cps_daily_report.php',
                'params' => array(
                    'start_date' => $start_date,
                    'end_date' => $end_date,
                    'cps' => $account_cps,
                ),
            ));
        }
        $ret_list = $this->multiSlaveServerRequest($request_list);

        $all_daily_report = array();
        foreach ($ret_list as $ret) {
            if ($ret === false) {
                continue;
            }
            if (isset($ret['error_code'])) {
                continue;
            }

            foreach ($ret as $row) {

                // `all cps` need to be the last one
                if ($row['cps'] === 'ALL') {
                    $index = $row['timestamp'].'9999999';
                } else {
                    $index = $row['timestamp'].$row['cps'];
                }
                if (isset($all_daily_report[$index]) === false) {
                    $item = array();
                    $item['timestamp'] = $row['timestamp'];
                    $item['daily_new_users'] = 0;
                    $item['daily_active_users'] = 0;
                    $item['daily_revenue'] = 0;
                    $item['daily_pay_times'] = 0;
                    $item['daily_pay_users'] = 0;
                    $all_daily_report[$index] = $item;
                }
                $sum_item = &$all_daily_report[$index];

                $sum_item['daily_new_users'] +=
                    $row['daily_new_users'];
                $sum_item['daily_active_users'] +=
                    $row['daily_active_users'];
                $sum_item['daily_revenue'] +=
                    $row['daily_revenue'];
                $sum_item['daily_pay_times'] +=
                    $row['daily_pay_times'];
                $sum_item['daily_pay_users'] +=
                    $row['daily_pay_users'];

                unset($sum_item);
            }
        }

        ksort($all_daily_report, SORT_STRING);
        $ret = array_values($all_daily_report);

        foreach ($ret as &$row) {
            $row['daily_revenue'] = sprintf("%.2f",
                $row['daily_revenue'] / 100.0);
            $row['daily_pay_rate'] = sprintf("%.2f%%",
                $row['daily_active_users'] > 0
                ? $row['daily_pay_users'] * 100.0 / $row['daily_active_users']
                : 0);
            $row['daily_arpu'] = sprintf("%.2f",
                $row['daily_active_users'] > 0
                ? $row['daily_revenue'] / $row['daily_active_users']
                : 0);
            $row['daily_arppu'] = sprintf("%.2f",
                $row['daily_pay_users'] > 0
                ? $row['daily_revenue'] / $row['daily_pay_users']
                : 0);
        }

        return $this->success(array(
            'all_cps_daily_report_list' => $ret,
        ));
    }

    public function getAllCpsMonthlyReportAction()
    {
        $this->view->disable();

        // check auth
        if ($this->hasAuth(AccountType::GM) == false) {
            return $this->error('not allowed');
        }

        $account_cps = $this->getAccountCps();
        $account_cps = ($account_cps == '' ? 'ALL' : $account_cps);

        $request_list = array();
        $server_model_list = $this->getVisableServerModelList();
        foreach ($server_model_list as $server_model) {
            array_push($request_list, array(
                'addr' => $server_model->addr,
                'secret_key' => $server_model->secret_key,
                'uri' => '/cps_monthly_report.php',
                'params' => array(
                    'cps' => $account_cps,
                ),
            ));
        }
        $ret_list = $this->multiSlaveServerRequest($request_list);

        $all_monthly_report = array();
        foreach ($ret_list as $ret) {
            if ($ret === false) {
                continue;
            }
            if (isset($ret['error_code'])) {
                continue;
            }

            foreach ($ret as $row) {
                // `all cps` need to be the last one
                if ($row['cps'] === 'ALL') {
                    $index = $row['timestamp'].'9999999';
                } else {
                    $index = $row['timestamp'].$row['cps'];
                }
                if (isset($all_monthly_report[$index]) === false) {
                    $item = array();
                    $item['index'] = $index;
                    $item['timestamp'] = $row['timestamp'];
                    $item['cps'] = $row['cps'];
                    $item['monthly_active_users'] = 0;
                    $item['monthly_revenue'] = 0;
                    $item['monthly_pay_times'] = 0;
                    $item['monthly_pay_users'] = 0;
                    $all_monthly_report[$index] = $item;
                }
                $sum_item = &$all_monthly_report[$index];

                $sum_item['monthly_active_users'] +=
                    $row['monthly_active_users'];
                $sum_item['monthly_revenue'] +=
                    $row['monthly_revenue'];
                $sum_item['monthly_pay_times'] +=
                    $row['monthly_pay_times'];
                $sum_item['monthly_pay_users'] +=
                    $row['monthly_pay_users'];

                unset($sum_item);
            }
        }

        ksort($all_monthly_report, SORT_STRING);
        $ret = array_values($all_monthly_report);

        foreach ($ret as &$row) {
            $row['monthly_revenue'] = sprintf("%.2f",
                $row['monthly_revenue'] / 100.0);
            $row['monthly_pay_rate'] = sprintf("%.2f%%",
                $row['monthly_active_users'] > 0 
                ? $row['monthly_pay_users'] * 100.0 /
                      $row['monthly_active_users']
                : 0);
            $row['monthly_arpu'] = sprintf("%.2f",
                $row['monthly_active_users'] > 0
                ? $row['monthly_revenue'] / $row['monthly_active_users']
                : 0);
            $row['monthly_arppu'] = sprintf("%.2f",
                $row['monthly_pay_users'] > 0
                ? $row['monthly_revenue'] / $row['monthly_pay_users']
                : 0);
        }

        return $this->success(array(
            'all_cps_monthly_report_list' => $ret,
        ));
    }

    public function getSpreadDailyReportAction()
    {
        $this->view->disable();

        // check auth
        if ($this->hasAuth(AccountType::ADVANCED_GM) == false) {
            return $this->error('not allowed');
        }

        // get params
        $server_id = $this->request->get('server_id');
        if ($server_id === null) {
            return $this->error('`server_id` is required');
        }
        $start_date = $this->request->get('start_date');
        if ($start_date === null) {
            return $this->error('`start_date` is required');
        }
        $end_date = $this->request->get('end_date');
        if ($end_date === null) {
            return $this->error('`end_date` is required');
        }

        // check server id
        $server_model = $this->getVisableServerModel($server_id);
        if ($server_model === false) {
            return $this->error('`server_id` is invalid');
        }

        $ret = $this->slaveServerRequest(
            $server_model->addr, $server_model->secret_key,
            '/spread_daily_report.php', array(
                'start_date' => $start_date,
                'end_date' => $end_date,
            ));
        if ($ret === false) {
            return $this->error('request slave server failed');
        }

        if (isset($ret['error_code'])) {
            return $this->success($ret);
        }

        foreach ($ret as &$row) {
            $row['spread'] =
                $this->getSpreadDesc($row['spread']);
            $row['daily_avg_online_time'] =
                (int)($row['daily_avg_online_time'] / 60);
            $row['daily_active_old_users'] =
                $row['daily_active_users'] - $row['daily_new_users'];
            $row['day1_retention_ratio'] = sprintf("%.2f%%",
                $row['day1_retention_ratio'] / 100.0);
            $row['day2_retention_ratio'] = sprintf("%.2f%%",
                $row['day2_retention_ratio'] / 100.0);
            $row['day3_retention_ratio'] = sprintf("%.2f%%",
                $row['day3_retention_ratio'] / 100.0);
            $row['day4_retention_ratio'] = sprintf("%.2f%%",
                $row['day4_retention_ratio'] / 100.0);
            $row['day5_retention_ratio'] = sprintf("%.2f%%",
                $row['day5_retention_ratio'] / 100.0);
            $row['day6_retention_ratio'] = sprintf("%.2f%%",
                $row['day6_retention_ratio'] / 100.0);
            $row['day7_retention_ratio'] = sprintf("%.2f%%",
                $row['day7_retention_ratio'] / 100.0);
            $row['day14_retention_ratio'] = sprintf("%.2f%%",
                $row['day14_retention_ratio'] / 100.0);
            $row['day15_retention_ratio'] = sprintf("%.2f%%",
                $row['day15_retention_ratio'] / 100.0);
            $row['day29_retention_ratio'] = sprintf("%.2f%%",
                $row['day29_retention_ratio'] / 100.0);
            $row['day30_retention_ratio'] = sprintf("%.2f%%",
                $row['day30_retention_ratio'] / 100.0);
            $row['daily_revenue'] = sprintf("%.2f",
                $row['daily_revenue'] / 100.0);
            $row['daily_pay_rate'] = sprintf("%.2f%%",
                $row['daily_active_users'] > 0 
                ? $row['daily_pay_users'] * 100.0 / $row['daily_active_users']
                : 0);
            $row['daily_arpu'] = sprintf("%.2f",
                $row['daily_arpu'] / 100.0);
            $row['daily_arppu'] = sprintf("%.2f",
                $row['daily_arppu'] / 100.0);
            $row['daily_new_user_revenue'] = sprintf("%.2f",
                $row['daily_new_user_revenue'] / 100.0);
            $row['daily_new_user_pay_rate'] = sprintf("%.2f%%",
                $row['daily_new_users'] > 0
                ? $row['daily_new_user_pay_users'] * 100.0 /
                  $row['daily_new_users']
                : 0);
        }

        return $this->success(array(
            'spread_daily_report_list' => $ret,
        ));
    }

    public function getSpreadAllDailyReportAction()
    {
        $this->view->disable();

        // check auth
        if ($this->hasAuth(AccountType::ADVANCED_GM) == false) {
            return $this->error('not allowed');
        }

        // get params
        $start_date = $this->request->get('start_date');
        if ($start_date === null) {
            return $this->error('`start_date` is required');
        }
        $end_date = $this->request->get('end_date');
        if ($end_date === null) {
            return $this->error('`end_date` is required');
        }
        $spread = $this->request->get('spread');
        if ($spread === null) {
            return $this->error('`spread` is required');
        }
        $spread = explode("-", $spread)[0];

        $request_list = array();
        $server_model_list = $this->getVisableServerModelList();
        foreach ($server_model_list as $server_model) {
            array_push($request_list, array(
                'addr' => $server_model->addr,
                'secret_key' => $server_model->secret_key,
                'uri' => '/spread_daily_report.php',
                'params' => array(
                    'start_date' => $start_date,
                    'end_date' => $end_date,
                ),
            ));
        }
        $ret_list = $this->multiSlaveServerRequest($request_list);

        $day_list = array(1, 2, 3, 4, 5, 6, 7, 14, 15, 29, 30);
        $all_daily_report = array();
        foreach ($ret_list as $ret) {
            if ($ret === false) {
                continue;
            }
            if (isset($ret['error_code'])) {
                continue;
            }

            foreach ($ret as $row) {
                if ($spread !== '' &&
                    $row['spread'] !== $spread) {
                    continue;
                }

                // `all channel` need to be the last one
                if ($row['spread'] === 'ALL') {
                    $index = $row['timestamp'].'9999999';
                } else {
                    $index = $row['timestamp'].$row['spread'];
                }
                if (isset($all_daily_report[$index]) === false) {
                    $item = array();
                    $item['timestamp'] = $row['timestamp'];
                    $item['spread'] =
                        $this->getSpreadDesc($row['spread']);
                    $item['daily_new_users'] = 0;
                    $item['daily_active_users'] = 0;
                    $item['daily_active_pay_users'] = 0;
                    $item['daily_revenue'] = 0;
                    $item['daily_pay_times'] = 0;
                    $item['daily_pay_users'] = 0;
                    $item['total_pay_users'] = 0;
                    $item['new_pay_users'] = 0;
                    $item['daily_new_user_revenue'] = 0;
                    $item['daily_new_user_pay_times'] = 0;
                    $item['daily_new_user_pay_users'] = 0;
                    $item['new_user_login_times'] = 0;
                    $item['old_user_login_times'] = 0;
                    $item['daily_avg_online_time'] = 0;
                    foreach ($day_list as $day) {
                        $item["day${day}_retention_ratio"] = 0;
                    }
                    $all_daily_report[$index] = $item;
                }
                $sum_item = &$all_daily_report[$index];

                $sum_item['daily_new_users'] +=
                    $row['daily_new_users'];
                $sum_item['daily_active_users'] +=
                    $row['daily_active_users'];
                $sum_item['daily_active_pay_users'] +=
                    $row['daily_active_pay_users'];
                $sum_item['daily_revenue'] +=
                    $row['daily_revenue'];
                $sum_item['daily_pay_times'] +=
                    $row['daily_pay_times'];
                $sum_item['daily_pay_users'] +=
                    $row['daily_pay_users'];
                $sum_item['total_pay_users'] +=
                    $row['total_pay_users'];
                $sum_item['new_pay_users'] +=
                    $row['new_pay_users'];
                $sum_item['daily_new_user_revenue'] +=
                    $row['daily_new_user_revenue'];
                $sum_item['daily_new_user_pay_times'] +=
                    $row['daily_new_user_pay_times'];
                $sum_item['daily_new_user_pay_users'] +=
                    $row['daily_new_user_pay_users'];
                $sum_item['new_user_login_times'] +=
                    $row['new_user_login_times'];
                $sum_item['old_user_login_times'] +=
                    $row['old_user_login_times'];
                $sum_item['daily_avg_online_time'] +=
                    $row['daily_avg_online_time'] * $row['daily_active_users'];
                foreach ($day_list as $day) {
                    $sum_item["day${day}_retention_ratio"] +=
                        $row["day${day}_retention_ratio"] *
                        $row['daily_new_users'];
                }

                unset($sum_item);
            }
        }

        ksort($all_daily_report, SORT_STRING);
        $ret = array_values($all_daily_report);

        foreach ($ret as &$row) {
            $row['daily_active_old_users'] =
                $row['daily_active_users'] - $row['daily_new_users'];
            $row['daily_revenue'] = sprintf("%.2f",
                $row['daily_revenue'] / 100.0);
            $row['daily_pay_rate'] = sprintf("%.2f%%",
                $row['daily_active_users'] > 0
                ? $row['daily_pay_users'] * 100.0 / $row['daily_active_users']
                : 0);
            $row['daily_new_user_revenue'] = sprintf("%.2f",
                $row['daily_new_user_revenue'] / 100.0);
            $row['daily_new_user_pay_rate'] = sprintf("%.2f%%",
                $row['daily_new_users'] > 0
                ? $row['daily_new_user_pay_users'] * 100.0 /
                  $row['daily_new_users']
                : 0);
            $row['daily_arpu'] = sprintf("%.2f",
                $row['daily_active_users'] > 0
                ? $row['daily_revenue'] / $row['daily_active_users']
                : 0);
            $row['daily_arppu'] = sprintf("%.2f",
                $row['daily_pay_users'] > 0
                ? $row['daily_revenue'] / $row['daily_pay_users']
                : 0);
            $row['daily_avg_online_time'] = sprintf("%d",
                $row['daily_active_users'] > 0
                ? (int)($row['daily_avg_online_time'] / 60 /
                        $row['daily_active_users'])
                : 0);
            foreach ($day_list as $day) {
                $row["day${day}_retention_ratio"] = sprintf("%.2f%%",
                    $row['daily_new_users'] > 0
                    ? $row["day${day}_retention_ratio"] /
                      $row['daily_new_users'] / 100.0
                    : 0);
            }
        }

        return $this->success(array(
            'spread_all_daily_report_list' => $ret,
        ));
    }

    public function getSpreadMonthlyReportAction()
    {
        $this->view->disable();

        // check auth
        if ($this->hasAuth(AccountType::ADVANCED_GM) == false) {
            return $this->error('not allowed');
        }

        // get params
        $server_id = $this->request->get('server_id');
        if ($server_id === null) {
            return $this->error('`server_id` is required');
        }

        // check server id
        $server_model = $this->getVisableServerModel($server_id);
        if ($server_model === false) {
            return $this->error('`server_id` is invalid');
        }

        $ret = $this->slaveServerRequest(
            $server_model->addr, $server_model->secret_key,
            '/spread_monthly_report.php');
        if ($ret === false) {
            return $this->error('request slave server failed');
        }

        if (isset($ret['error_code'])) {
            return $this->success($ret);
        }

        foreach ($ret as &$row) {
            $row['spread'] =
                $this->getSpreadDesc($row['spread']);
            $row['monthly_revenue'] = sprintf("%.2f",
                $row['monthly_revenue'] / 100.0);
            $row['monthly_pay_rate'] = sprintf("%.2f%%",
                $row['monthly_active_users'] > 0 
                ? $row['monthly_pay_users'] * 100.0 /
                      $row['monthly_active_users']
                : 0);
            $row['monthly_arpu'] = sprintf("%.2f",
                $row['monthly_arpu'] / 100.0);
            $row['monthly_arppu'] = sprintf("%.2f",
                $row['monthly_arppu'] / 100.0);
        }

        return $this->success(array(
            'spread_monthly_report_list' => $ret,
        ));
    }

    public function getSpreadAllMonthlyReportAction()
    {
        $this->view->disable();

        // check auth
        if ($this->hasAuth(AccountType::ADVANCED_GM) == false) {
            return $this->error('not allowed');
        }

        $request_list = array();
        $server_model_list = $this->getVisableServerModelList();
        foreach ($server_model_list as $server_model) {
            array_push($request_list, array(
                'addr' => $server_model->addr,
                'secret_key' => $server_model->secret_key,
                'uri' => '/spread_monthly_report.php',
            ));
        }
        $ret_list = $this->multiSlaveServerRequest($request_list);

        $all_monthly_report = array();
        foreach ($ret_list as $ret) {
            if ($ret === false) {
                continue;
            }
            if (isset($ret['error_code'])) {
                continue;
            }

            foreach ($ret as $row) {
                // `all channel` need to be the last one
                if ($row['spread'] === 'ALL') {
                    $index = $row['timestamp'].'9999999';
                } else {
                    $index = $row['timestamp'].$row['spread'];
                }
                if (isset($all_monthly_report[$index]) === false) {
                    $item = array();
                    $item['index'] = $index;
                    $item['timestamp'] = $row['timestamp'];
                    $item['spread'] =
                        $this->getSpreadDesc($row['spread']);
                    $item['monthly_new_users'] = 0;
                    $item['monthly_active_users'] = 0;
                    $item['monthly_revenue'] = 0;
                    $item['monthly_pay_times'] = 0;
                    $item['monthly_pay_users'] = 0;
                    $all_monthly_report[$index] = $item;
                }
                $sum_item = &$all_monthly_report[$index];

                $sum_item['monthly_new_users'] +=
                    $row['monthly_new_users'];
                $sum_item['monthly_active_users'] +=
                    $row['monthly_active_users'];
                $sum_item['monthly_revenue'] +=
                    $row['monthly_revenue'];
                $sum_item['monthly_pay_times'] +=
                    $row['monthly_pay_times'];
                $sum_item['monthly_pay_users'] +=
                    $row['monthly_pay_users'];

                unset($sum_item);
            }
        }

        ksort($all_monthly_report, SORT_STRING);
        $ret = array_values($all_monthly_report);

        foreach ($ret as &$row) {
            $row['monthly_revenue'] = sprintf("%.2f",
                $row['monthly_revenue'] / 100.0);
            $row['monthly_pay_rate'] = sprintf("%.2f%%",
                $row['monthly_active_users'] > 0 
                ? $row['monthly_pay_users'] * 100.0 /
                      $row['monthly_active_users']
                : 0);
            $row['monthly_arpu'] = sprintf("%.2f",
                $row['monthly_active_users'] > 0
                ? $row['monthly_revenue'] / $row['monthly_active_users']
                : 0);
            $row['monthly_arppu'] = sprintf("%.2f",
                $row['monthly_pay_users'] > 0
                ? $row['monthly_revenue'] / $row['monthly_pay_users']
                : 0);
        }

        return $this->success(array(
            'spread_all_monthly_report_list' => $ret,
        ));
    }

}
