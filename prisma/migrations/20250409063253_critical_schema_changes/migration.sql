/*
  Warnings:

  - You are about to drop the column `timestamp` on the `HumidityReading` table. All the data in the column will be lost.
  - You are about to drop the column `timestamp` on the `TemperatureReading` table. All the data in the column will be lost.
  - You are about to drop the column `timestamp` on the `WindSpeedReading` table. All the data in the column will be lost.

*/
-- DropIndex
DROP INDEX "HumidityReading_timestamp_idx";

-- DropIndex
DROP INDEX "TemperatureReading_timestamp_idx";

-- DropIndex
DROP INDEX "WindSpeedReading_timestamp_idx";

-- AlterTable
ALTER TABLE "HumidityReading" DROP COLUMN "timestamp",
ADD COLUMN     "date" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
ADD COLUMN     "time" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP;

-- AlterTable
ALTER TABLE "TemperatureReading" DROP COLUMN "timestamp",
ADD COLUMN     "date" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
ADD COLUMN     "time" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP;

-- AlterTable
ALTER TABLE "WindSpeedReading" DROP COLUMN "timestamp",
ADD COLUMN     "date" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
ADD COLUMN     "time" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP;

-- CreateIndex
CREATE INDEX "HumidityReading_date_time_idx" ON "HumidityReading"("date", "time");

-- CreateIndex
CREATE INDEX "TemperatureReading_date_time_idx" ON "TemperatureReading"("date", "time");

-- CreateIndex
CREATE INDEX "WindSpeedReading_date_time_idx" ON "WindSpeedReading"("date", "time");
