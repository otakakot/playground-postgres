CREATE FUNCTION set_updated_at() RETURNS TRIGGER AS $$
BEGIN
  IF (TG_OP = 'UPDATE') THEN
    NEW.updated_at := now();
    return NEW;
  END IF;
END;
$$ LANGUAGE plpgsql;
