package com.mit.elis.class_common;

import jakarta.servlet.annotation.WebListener;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.HttpSessionBindingEvent;
import jakarta.servlet.http.HttpSessionListener;

/**
 * Application Lifecycle Listener implementation class sessiontracker
 *
 */
@WebListener
public class sessiontracker implements HttpSessionListener {

	private static int totalActiveSessions;

	public static int getTotalActiveSession() {
		return totalActiveSessions;
	}

	/**
	 * Default constructor.
	 */
	public sessiontracker() {
		// TODO Auto-generated constructor stub

	}

	/**
	 * @see HttpSessionListener#sessionCreated(HttpSessionEvent)
	 */
	public void sessionCreated(HttpSession arg0) {
		// TODO Auto-generated method stub
		totalActiveSessions++;
		System.out.println("sessionCreated - add one session into counter");
	}

	/**
	 * @see HttpSessionListener#sessionDestroyed(HttpSessionEvent)
	 */
	public void sessionDestroyed(HttpSessionBindingEvent arg0) {
		// TODO Auto-generated method stub
		totalActiveSessions--;
		System.out.println("sessionDestroyed - deduct one session from counter");
	}

}
