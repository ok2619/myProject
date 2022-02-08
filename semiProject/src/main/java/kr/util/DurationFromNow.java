package kr.util;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;

public class DurationFromNow {
	/**
	 * 현재부터 "yyyyMMddHHmmss" 포맷의 날짜 차이 레이블
	 * @param date1
	 * @return String
	 */
	public static String getTimeDiffLabel(String date1) {
		try {
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
			
			return getTimeDiffLabel(sdf.parse(date1), new Date());
		} catch (ParseException e) {
			return "-";
		}
	}

	/**
	 * 현재부터 Date 포맷의 날짜 차이 레이블
	 * @param d1
	 * @return String
	 */
	public static String getTimeDiffLabel(Date d1) {
		return getTimeDiffLabel(d1, new Date());
	}

	/**
	 * "yyyyMMddHHmmss" 포맷의 날짜 차이 레이블
	 * @param date1
	 * @param date2
	 * @return String
	 */
	public static String getTimeDiffLabel(String date1, String date2) {
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd- HH:mm:ss");
		try {
			return getTimeDiffLabel(sdf.parse(date1), sdf.parse(date2));
		} catch (ParseException e) {
			return "-";
		}
	}

	/**
	 * java.util.Date 포맷의 날짜 차이 레이블
	 * @param d1
	 * @param d2
	 * @return String
	 */
	public static String getTimeDiffLabel(Date d1, Date d2) {
		long diff = d2.getTime() - d1.getTime();
		int sec = (int)(diff / 1000);
		if (sec < 5) return "5초미만";
		if (sec < 60) return sec + "초 전";

		int min = (int)(sec / 60);
		if (min < 60) return min + "분 전";

		int hour = (int)(min / 60);
		if (hour < 24) return hour + "시간 전";

		Calendar c1 = Calendar.getInstance();
		Calendar c2 = (Calendar) c1.clone();
		c1.setTime(d1);
		c2.setTime(d2);

		int day = c2.get(Calendar.DATE) - c1.get(Calendar.DATE);
		if (day <= 0) {
			day = hour / 24;
		}

		if (hour/24 < 30) {
			if (day == 1) return "어제";
			if (day == 2) return "2일전";
			return day + "일전";
		}

		int month = hour / 24 / 30;
		if (month == 1) return "한 달전";
		if (month == 2) return "두 달전";
		if (month < 12) return month + "달전";

		int year = month / 12;
		if (year == 1) return "작년";
		return year + "년전";

	}
}