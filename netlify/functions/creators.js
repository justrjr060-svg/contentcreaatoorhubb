import { getDatabase } from "@netlify/database";

const db = getDatabase();

// Keep stored values tidy and within sane bounds.
function clean(value, max) {
  return String(value ?? "").trim().slice(0, max);
}

// Strip a social handle down to its bare username.
function handle(value) {
  return clean(value, 80).replace(/^@+/, "").replace(/\s+/g, "");
}

export default async (req) => {
  if (req.method === "GET") {
    const rows = await db.sql`
      SELECT id, name, category, bio, twitter, instagram, tiktok, website, created_at
      FROM creators
      ORDER BY created_at DESC
      LIMIT 100
    `;
    return Response.json(rows);
  }

  if (req.method === "POST") {
    let body;
    try {
      body = await req.json();
    } catch {
      return Response.json({ error: "Invalid request." }, { status: 400 });
    }

    const name = clean(body.name, 80);
    if (!name) {
      return Response.json({ error: "A display name is required." }, { status: 400 });
    }

    const category = clean(body.category, 40) || "Creator";
    const bio = clean(body.bio, 400);
    const twitter = handle(body.twitter);
    const instagram = handle(body.instagram);
    const tiktok = handle(body.tiktok);
    let website = clean(body.website, 200);
    if (website && !/^https?:\/\//i.test(website)) {
      website = "https://" + website;
    }

    const [creator] = await db.sql`
      INSERT INTO creators (name, category, bio, twitter, instagram, tiktok, website)
      VALUES (${name}, ${category}, ${bio}, ${twitter}, ${instagram}, ${tiktok}, ${website})
      RETURNING id, name, category, bio, twitter, instagram, tiktok, website, created_at
    `;
    return Response.json(creator, { status: 201 });
  }

  return new Response("Method not allowed", { status: 405 });
};

export const config = {
  path: "/api/creators",
};
