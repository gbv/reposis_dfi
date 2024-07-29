/*
 * This file is part of ***  M y C o R e  ***
 * See http://www.mycore.de/ for details.
 *
 * MyCoRe is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * MyCoRe is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with MyCoRe.  If not, see <http://www.gnu.org/licenses/>.
 */

package de.gbv.reposis.dfi;

import java.nio.file.Files;
import java.util.Arrays;
import java.util.HashSet;
import java.util.Optional;
import java.util.Set;

import org.mycore.datamodel.classifications2.MCRCategoryID;
import org.mycore.datamodel.metadata.MCRDerivate;
import org.mycore.datamodel.metadata.MCRMetadataManager;
import org.mycore.datamodel.metadata.MCRObject;
import org.mycore.datamodel.metadata.MCRObjectID;
import org.mycore.iiif.image.impl.MCRIIIFImageNotFoundException;
import org.mycore.iview2.backend.MCRTileInfo;
import org.mycore.iview2.iiif.MCRThumbnailImageImpl;

/**
 * This class is a custom implementation of the {@link MCRThumbnailImageImpl} class. It returns the first derivate of a
 * given object that has a classification that matches one of the types specified in the configuration and were the user
 * has the permission to access the file.
 */
public class DFIThumbnailImageImpl extends MCRThumbnailImageImpl {

    public DFIThumbnailImageImpl(String implName) {
        super(implName);
        derivateTypes = new HashSet<>();
        derivateTypes.addAll(Arrays.asList(getProperties().get(DERIVATE_TYPES).split(",")));
    }

    protected static final String DERIVATE_TYPES = "Derivate.Types";

    private Set<String> derivateTypes;

    @Override
    protected MCRTileInfo createTileInfo(String id) throws MCRIIIFImageNotFoundException {
        MCRObjectID mcrID = calculateMCRObjectID(id).orElseThrow(() -> new MCRIIIFImageNotFoundException(id));
        if (mcrID.getTypeId().equals("derivate")) {
            MCRDerivate mcrDer = MCRMetadataManager.retrieveMCRDerivate(mcrID);
            return new MCRTileInfo(mcrID.toString(), mcrDer.getDerivate().getInternals().getMainDoc(), null);
        } else {
            MCRObject mcrObj = MCRMetadataManager.retrieveMCRObject(mcrID);
            return mcrObj.getStructure().getDerivates().stream()
                    .filter(derLink -> derLink.getClassifications().stream()
                            .map(MCRCategoryID::toString)
                            .anyMatch(derivateTypes::contains))
                    .filter(derLink -> derLink.getMainDoc() != null)
                    .map(derLink -> createTileInfoForFile(derLink.getXLinkHref(), derLink.getMainDoc()))
                    .filter(Optional::isPresent)
                    .map(Optional::get)
                    .filter(tileInfo -> checkPermission(id, tileInfo))
                    .findFirst()
                    .orElseThrow(() -> new MCRIIIFImageNotFoundException(id));
        }
    }

    private Optional<MCRTileInfo> createTileInfoForFile(String derID, String file) {
        final MCRTileInfo mcrTileInfo = new MCRTileInfo(derID, file, null);
        return Optional.of(mcrTileInfo)
                .filter(t -> this.tileFileProvider.getTileFile(t).filter(Files::exists).isPresent());
    }
}
