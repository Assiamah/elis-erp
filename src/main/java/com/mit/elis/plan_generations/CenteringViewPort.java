package com.mit.elis.plan_generations;

import java.awt.Dimension;

import com.vividsolutions.jts.geom.Envelope;

public class CenteringViewPort {

	// calculated factor so all geometries will be in the picture
	double scalingFactor;

	// fixed correction of scaling factor so extra padding is created around the
	// geometries
	double bufferFactor = 0.8;

	// calculated offsets so geometries are centered in the pictured
	int offsetX, offsetY;

	public CenteringViewPort(Dimension dim, Envelope env) {

		// extreme points of envelope (created from union of geometries)

		double minX = env.getMinX();
		double maxX = env.getMaxX();
		double minY = env.getMinY();
		double maxY = env.getMaxY();

		// size of the envelope

		double lenX = maxX - minX;
		double lenY = maxY - minY;

		// world coordinates of the middle of the envelope

		double cenX = minX + (maxX - minX) / 2;
		double cenY = minY + (maxY - minY) / 2;

		// scaling factor

		scalingFactor = Math.min(dim.getHeight() / lenX, dim.getWidth() / lenY) * bufferFactor;

		// world coordinates of the middle of the image

		double imgX = dim.getWidth() / 2 / scalingFactor;
		double imgY = dim.getHeight() / 2 / scalingFactor;

		// offsets necessary to keep things centered

		offsetX = (int) (imgX - cenX);
		offsetY = (int) (imgY - cenY);

	}

	// transformation of screen/image coordinate into world coordinate

	public double getWorldX(double screen) {
		return getWorldCoordinate(screen, offsetX);
	}

	public double getWorldY(double screen) {
		return getWorldCoordinate(screen, offsetY);
	}

	private double getWorldCoordinate(double screen, int offset) {
		return (int) (screen / scalingFactor - offset);
	}

	// transformation of screen/image coordinate into world coordinate

	public int getScreenX(double world) {
		return getScreenCoordinate(world, offsetX);
	}

	public int getScreenY(double world) {
		return getScreenCoordinate(world, offsetY);
	}

	private int getScreenCoordinate(double world, int offset) {
		return (int) ((world + offset) * scalingFactor);
	}

}
