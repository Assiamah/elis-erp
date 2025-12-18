package com.mit.elis.plan_generations;

import java.awt.Color;
import java.awt.Dimension;
import java.awt.Graphics;
import java.awt.image.BufferedImage;
import java.io.File;
import java.io.IOException;

// import jakarta.imageio.ImageIO;

import com.vividsolutions.jts.geom.Coordinate;
import com.vividsolutions.jts.geom.Geometry;
import com.vividsolutions.jts.geom.GeometryCollection;
import com.vividsolutions.jts.geom.Polygon;

public class Renderer {

	private Dimension dim;
	private GeometryCollection geometries;

	private CenteringViewPort viewPort;

	public Renderer(Dimension dim, GeometryCollection geometries) {

		this.dim = dim;
		this.geometries = geometries;
		this.viewPort = new CenteringViewPort(dim, geometries.getEnvelopeInternal());

	}

	public BufferedImage rasterize() {

		// create the buffered image of the size of the Rectangle
		BufferedImage image = new BufferedImage(dim.width, dim.height, BufferedImage.TYPE_INT_ARGB);

		// define the clipping region in world coordinates
		Coordinate[] coords = new Coordinate[] {

				new Coordinate(0, 0),

				new Coordinate(viewPort.getWorldX(dim.getWidth()), 0),
				new Coordinate(viewPort.getWorldX(dim.getWidth()), viewPort.getWorldY(dim.getHeight())),
				new Coordinate(0, viewPort.getWorldY(dim.getHeight())),

				new Coordinate(0, 0)

		};

		// clipping geometry
		Polygon geom = GeometryUtils.GEO_FACTORY.createPolygon(GeometryUtils.GEO_FACTORY.createLinearRing(coords));

		// image graphics used for rendering
		Graphics g2d = image.getGraphics();
		g2d.setColor(Color.white);

		for (int index = 0; index < geometries.getNumGeometries(); index++) {

			Geometry geo = geometries.getGeometryN(index);

			// drawing only those geometries that are at least partially within
			// clipping region
			// if (geo.intersects(geom)) {

			int[] xPoints = new int[geo.getNumPoints()];// build array for x
														// coordinates
			int[] yPoints = new int[geo.getNumPoints()];// build array for y
														// coordinates
			int i = 0;

			for (Coordinate c : geo.getCoordinates()) {

				// polygons' coordinates being transformed into screen/image
				// coordinates
				xPoints[i] = viewPort.getScreenX(c.x);
				yPoints[i] = viewPort.getScreenY(c.y);
				i++;

			}

			// drawing transformed polygon onto image graphics
			g2d.fillPolygon(xPoints, yPoints, i);

			// }

		}

		g2d.dispose();
		return image;

	}

	public void rasterizeToFile(File outputfile, String formatName) throws IOException {
		//ImageIO.write(rasterize(), formatName, outputfile);
	}

}
