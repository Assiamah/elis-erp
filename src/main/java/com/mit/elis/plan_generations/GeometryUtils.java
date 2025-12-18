package com.mit.elis.plan_generations;

import com.vividsolutions.jts.geom.Geometry;
import com.vividsolutions.jts.geom.GeometryCollection;
import com.vividsolutions.jts.geom.GeometryFactory;
import com.vividsolutions.jts.geom.PrecisionModel;
import com.vividsolutions.jts.io.ParseException;
import com.vividsolutions.jts.io.WKTReader;
import com.vividsolutions.jts.io.geojson.GeoJsonReader;

public class GeometryUtils {

	public static final int SRID = 2136;
	public static final int DECIMAL_PRECISION = 10;

	public static final GeometryFactory GEO_FACTORY = new GeometryFactory(new PrecisionModel(DECIMAL_PRECISION), SRID);

	private static final WKTReader WKT_READER = new WKTReader();

	public static Geometry read(String wkt) throws ParseException {
		return WKT_READER.read(wkt);
	}

	public static Geometry[] readArray(String... wkts) throws ParseException {

		if (wkts == null) {
			return null;
		}

		if (wkts.length == 0) {
			return null;
		}

		Geometry[] geometries = new Geometry[wkts.length];
		int idx = 0;

		for (String wkt : wkts) {
			geometries[idx++] = WKT_READER.read(wkt);
		}

		return geometries;

	}

	public static GeometryCollection readCollection(String... wkts) throws ParseException {
		return new GeometryCollection(GeometryUtils.readArray(wkts), GeometryUtils.GEO_FACTORY);

	}

	public static void String() {

		try {
			GeoJsonReader reader = new GeoJsonReader();
			Geometry geometry = reader.read("");
		} catch (ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

}
