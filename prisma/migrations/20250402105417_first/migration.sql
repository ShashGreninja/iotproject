-- CreateEnum
CREATE TYPE "SensorType" AS ENUM ('TEMPERATURE', 'HUMIDITY', 'WIND_SPEED');

-- CreateTable
CREATE TABLE "Sensor" (
    "id" SERIAL NOT NULL,
    "type" "SensorType" NOT NULL,
    "location" TEXT NOT NULL,
    "unit" TEXT NOT NULL,

    CONSTRAINT "Sensor_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "TemperatureReading" (
    "id" SERIAL NOT NULL,
    "sensorId" INTEGER NOT NULL,
    "value" DECIMAL(5,2) NOT NULL,
    "timestamp" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "TemperatureReading_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "HumidityReading" (
    "id" SERIAL NOT NULL,
    "sensorId" INTEGER NOT NULL,
    "value" DECIMAL(5,2) NOT NULL,
    "timestamp" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "HumidityReading_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "WindSpeedReading" (
    "id" SERIAL NOT NULL,
    "sensorId" INTEGER NOT NULL,
    "value" DECIMAL(5,2) NOT NULL,
    "timestamp" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "WindSpeedReading_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE UNIQUE INDEX "Sensor_type_location_key" ON "Sensor"("type", "location");

-- CreateIndex
CREATE INDEX "TemperatureReading_timestamp_idx" ON "TemperatureReading"("timestamp");

-- CreateIndex
CREATE INDEX "HumidityReading_timestamp_idx" ON "HumidityReading"("timestamp");

-- CreateIndex
CREATE INDEX "WindSpeedReading_timestamp_idx" ON "WindSpeedReading"("timestamp");

-- AddForeignKey
ALTER TABLE "TemperatureReading" ADD CONSTRAINT "TemperatureReading_sensorId_fkey" FOREIGN KEY ("sensorId") REFERENCES "Sensor"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "HumidityReading" ADD CONSTRAINT "HumidityReading_sensorId_fkey" FOREIGN KEY ("sensorId") REFERENCES "Sensor"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "WindSpeedReading" ADD CONSTRAINT "WindSpeedReading_sensorId_fkey" FOREIGN KEY ("sensorId") REFERENCES "Sensor"("id") ON DELETE CASCADE ON UPDATE CASCADE;
